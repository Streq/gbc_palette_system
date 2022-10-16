extends Node

#to use this class you would first record gameplay
#HOW TO RECORD GAMEPLAY
#set autoplay off in the editor
#set the demo name (careful not to overwrite existing demos)
#assign the flapper you wanna record
#assign the flapper you wanna replay if there is one
#run the scene
#start recording by pressing 1
#when you are done press 2
#save the recording with 3
#exit the scene
#load the recording with 4

var recording := false
var events := []
var frame := 0
export var replay_index := 0
export var autoplay := false
export var autorecord := false

var saved_events := []
export var record_input_state_path : NodePath
onready var record_input_state : InputState = get_node(record_input_state_path) if has_node(record_input_state_path) else null
export var replay_input_state_path : NodePath
onready var replay_input_state : InputState = get_node(replay_input_state_path) if has_node(replay_input_state_path) else null

export var demo_name := "demo.dat"


enum STATE {
	IDLE,
	RECORDING,
	REPLAYING
}

var state : int = STATE.IDLE

class Event:
	var frame := 0
	var A := false
	var B := false
	var dir := Vector2()

	func _init(frame: int, A := false, B := false, dir := Vector2()) ->void:
		self.frame = frame
		self.A = A
		self.B = B
		self.dir = dir
	func equals(e:Event):
		return A == e.A and B == e.B and dir == e.dir
	
	static func from_dict(dict):
		return Event.new(dict.frame,dict.A,dict.B,dict.dir)
	func to_dict():
		return {
			"frame":frame,
			"A":A,
			"B":B,
			"dir":dir
		}

func record():
	change_state(STATE.RECORDING)
func idle():
	change_state(STATE.IDLE)
func replay():
	change_state(STATE.REPLAYING)

func _ready() -> void:
	change_state(STATE.IDLE)
	if autoplay:
		load_recording()
		replay()
	elif autorecord:
		record()
	

func _physics_process(delta: float) -> void:
	match state:
		STATE.IDLE:
			pass
		STATE.RECORDING:
			if is_instance_valid(record_input_state):
				var e = Event.new(
					frame,
					record_input_state.A.is_pressed(),
					record_input_state.B.is_pressed(),
					record_input_state.dir
					)
				if events.empty() or !events[-1].equals(e):
					events.push_back(e)
				frame += 1
			else:
				idle()
				return
		STATE.REPLAYING:
			var saved_event = saved_events[replay_index]
			if is_instance_valid(replay_input_state):
				if frame == saved_event.frame:
					replay_input_state.A.set_pressed(saved_event.A)
					replay_input_state.B.set_pressed(saved_event.B)
					replay_input_state.dir = (saved_event.dir)
					replay_index += 1
					
					if replay_index >= saved_events.size():
						idle()
						return
				frame += 1
			else:
				idle()
				return
		


func change_state(new_state:int):
	exit_current_state()
	state = new_state
	enter_current_state()

func exit_current_state():
	match state:
		STATE.IDLE:
			pass
		STATE.RECORDING:
			saved_events = events
			events = []
			frame = 0
		STATE.REPLAYING:
			frame = 0

func enter_current_state():
	match state:
		STATE.IDLE:
			events = []
			frame = 0
		STATE.RECORDING:
			events = []
			frame = 0
		STATE.REPLAYING:
#			replay_index = 0
			frame = 0

const PATH = "res://assets/data/"
func save_recording():
	var file = File.new()
	file.open(PATH+demo_name, File.WRITE)
	var saved_as_dict = []
	for event in saved_events:
		saved_as_dict.push_back(event.to_dict())
	file.store_var(saved_as_dict)
	file.close()
func load_recording():
	var file = File.new()
	file.open(PATH+demo_name, File.READ)
	saved_events = []
	var saved_as_dict = file.get_var()
	for dict in saved_as_dict:
		saved_events.push_back(Event.from_dict(dict))
	file.close()

func _unhandled_key_input(event: InputEventKey) -> void:
	if autoplay:
		return
	if OS.is_debug_build():
		if event.is_pressed():
			match event.scancode:
				KEY_1:
					record()
				KEY_2:
					replay()
				KEY_3:
					save_recording()
				KEY_4:
					load_recording()
					
					
