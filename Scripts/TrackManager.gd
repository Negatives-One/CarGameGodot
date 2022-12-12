extends Spatial

class_name TrackManager

export var checkpoints : Array = []

var currentID = null

var started : bool = false
var timeElapsed : float = 0
var timePerCheck : Array = []
var result : float = 0
var lastTime : float = 0
var bestTime : float = 0

var checkpointsNode : Array = []

var nextCheck : int = 0
var nextNextCheck : int = 1

export(NodePath) var carPath : NodePath

export(NodePath) var carPath2 = null

signal onCheckPointEntered(id, player)

func _ready():
	InGameUi.visible = true
	InGameUi.manager = self
	InGameUi.set_physics_process(true)
	if(carPath2 == null):
		for i in range(len(checkpoints)):
			var point : Area = get_node(checkpoints[i])
			point.id = i
			#point.connect("onCheckPointEntered", self, "CheckPointEntered")
			checkpointsNode.append(point)
			if(i == 0):
				point.SetInitial()
		UpdateCheckpoints(4)
		connect("onCheckPointEntered", self, "CheckPointEntered")
	InGameUi.car = get_node((carPath))

func _physics_process(delta):
	if(started):
		timeElapsed += delta
		SetResult()
		result += timeElapsed

func CheckPointEntered(id : int, _player : Node):
	if(!started && id == 0):
		started = true
		timePerCheck.clear()
		currentID = 0;
	if(started):
		if(id == currentID+1):
			timePerCheck.append(timeElapsed)
			currentID += 1
			SetResult()
	if(started && id == 0):
		timePerCheck.append(timeElapsed)
		currentID = 0
		SetResult()
		lastTime = result
		if(bestTime == 0.0):
			bestTime = lastTime
		if(lastTime < bestTime):
			bestTime = lastTime
		timePerCheck.clear()
	timeElapsed = 0
	
	UpdateCheckpoints(id)

func SetResult():
	result = 0
	for i in timePerCheck:
		result += i

func UpdateCheckpoints(lastID : int) -> void:
	var next : int = lastID + 1
	var nextNext : int = lastID + 2
	if(next == checkpointsNode.size()):
		next = 0
	if(nextNext == checkpointsNode.size()):
		nextNext = 0
	if(nextNext == checkpointsNode.size() + 1):
		nextNext = 1
		
	for i in checkpointsNode:
		if(next == i.id or nextNext == i.id):
			i.visible = true
		else:
			i.visible = false
			
	if(lastID < checkpoints.size() - 1):
		pass
