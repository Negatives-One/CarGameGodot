extends Node

class_name GearBox


var Gears : Array = ["R", "D"];
var maxGear : int;
export var currentGear : int = 1;

func _ready():
	maxGear = Gears.size() - 1;

func _process(_delta):
	if (Input.is_action_just_pressed(get_parent().gearDownInput + str(get_parent().playerCount))):
		GearDown();
	if (Input.is_action_just_pressed(get_parent().gearUpInput + str(get_parent().playerCount))):
		GearUp();

func GearDown() -> void:
	if (currentGear > 0):
		currentGear -= 1;

func GearUp() -> void:
	if (currentGear < maxGear):
		currentGear += 1;

func GetGearName() -> String:
	return Gears[currentGear];
