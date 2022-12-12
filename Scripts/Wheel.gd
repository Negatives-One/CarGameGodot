extends VehicleWheel

class_name Wheel

export(NodePath) var raycastPath : NodePath
var raycast : RayCast

func _ready():
	raycast = get_node(raycastPath)


func _physics_process(_delta : float) -> void:
	var body = raycast.get_collider()
	if (body != null):
		if (body.is_in_group("Normal")):
			SetFrictionNormal()
		elif(body.is_in_group("Ice")):
			SetFrictionIce()

func SetFrictionNormal() -> void:
	wheel_friction_slip = 2.0
	wheel_roll_influence = 0.025

func SetFrictionIce() -> void:
	wheel_friction_slip = 0.6
	wheel_roll_influence = 2
