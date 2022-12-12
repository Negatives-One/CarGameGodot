extends Spatial

class_name ChaseCameraPivot

var direction = Vector3.FORWARD
export (float, 1, 10, 0.1) var smoothSpeed

export(NodePath) var carPath
onready var car : Spatial = get_node(carPath)

func _ready():
	pass

func _physics_process(delta):
	self.translation = car.translation
	var current_vel = car.get_linear_velocity()
	current_vel.y = 0
	if current_vel.length_squared() > 1:
		direction = lerp(direction, -current_vel.normalized(), smoothSpeed*delta)
	global_transform.basis = GetRotationByDir(direction)
	

func GetRotationByDir(dir : Vector3) -> Basis:
	dir = dir.normalized()
	var xAxis = dir.cross(Vector3.UP)
	return Basis(xAxis, Vector3.UP, -dir)
