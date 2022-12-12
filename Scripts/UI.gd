extends Control

export(NodePath) var timeManager : NodePath

var manager
var car : ArcadeCar

func _physics_process(_delta):
	if(manager):
		$ColorRect/Label.text = " Time: " + str(manager.result).pad_decimals(2)
		$ColorRect/Label2.text = " Last Lap: " + str(manager.lastTime).pad_decimals(2)
		$ColorRect/Label3.text = " Best Lap: " + str(manager.bestTime).pad_decimals(2)
	if(car):
		var rpmAngle : float = Map(car.linear_velocity.length(), 0.0, 30.0, 0.0, 261.0)
		$contaGiro/ponteiro.set_rotation(deg2rad(rpmAngle))
		$Gear.text = "Gear: " + car.gearBox.GetGearName()

func Map(value : float, start1 : float, stop1 : float, start2 : float, stop2 : float) -> float:
	var outgoing : float = start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1))
	return outgoing;


func _on_Continue_pressed():
	$PausePanel.visible = false
	get_tree().paused = false


func _on_MainMenu_pressed():
	self.visible = false
	var _errorValue : int = get_tree().change_scene("res://MainMenu.tscn")
	set_physics_process(false)
	$PausePanel.visible = false
	get_tree().paused = false

func Pause() -> void:
	$PausePanel.visible = true
	get_tree().paused = true
