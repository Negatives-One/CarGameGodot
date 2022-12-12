extends VehicleBody

class_name ArcadeCar

export var maxRPM : float = 8000
export var maxTorque : float = 100;
export var brakeForce : float = 100;

var deltaTime := 0.0;

var steerFactor := 0.1;

var accelerating := false;
var braking := false;
var handBraking := false;
var steerLeft := false;
var steerRight := false;
var boosting := false;

var steer : float = 0;
var wheelBase : float;
var rearTrack : float;

var turnRadius : float = 0;

export(Array) var wheelPaths : Array;
export(NodePath) var gearBoxPath : NodePath;

var frontLeft : VehicleWheel;
var frontRight : VehicleWheel;
var backLeft : VehicleWheel;
var backRight : VehicleWheel;
var gearBox : GearBox;

var accelerationDirection = 1;

export var playerCount : int = 1
const leftInput : String = "Left"
const rightInput : String = "Right"
const accelerateInput : String = "Accelerate"
const brakeInput : String = "Brake"
const handbrakeInput : String = "Handbrake"
const gearUpInput : String = "GearUp"
const gearDownInput : String = "GearDown"
const pauseInput : String = "Pause"
# Called when the node enters the scene tree for the first time.
func _ready():
	frontLeft = get_node(wheelPaths[0]);
	frontRight = get_node(wheelPaths[1]);
	backLeft = get_node(wheelPaths[2]);
	backRight = get_node(wheelPaths[3]);
	
	gearBox = get_node(gearBoxPath);
	
	wheelBase = frontLeft.translation.distance_to(backLeft.translation);
	rearTrack = backLeft.translation.distance_to(backRight.translation);

#func _input(event):
#	var newEvent : InputEventKey = event as InputEventKey;
#	if (newEvent != null):
#		if (newEvent.scancode == KEY_W && !newEvent.echo):
#			accelerating = !accelerating;
#		if (newEvent.scancode == KEY_S && !newEvent.echo):
#			braking = !braking;
#		if (newEvent.scancode == KEY_SPACE && !newEvent.echo):
#			handBraking = !handBraking;
#		if (newEvent.scancode == KEY_A && !newEvent.echo):
#			steerLeft = !steerLeft;
#		if (newEvent.scancode == KEY_D && !newEvent.echo):
#			steerRight = !steerRight;
#		if (newEvent.scancode == KEY_SHIFT && !newEvent.echo):
#			boosting = !boosting;
#		if (newEvent.scancode == KEY_ESCAPE && !newEvent.echo):
#			InGameUi.Pause()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	deltaTime = delta;
	steering = Input.get_axis(rightInput + str(playerCount), leftInput + str(playerCount)) * 0.4;
	var acceleration : float = Input.get_action_strength(accelerateInput + str(playerCount));

	if (gearBox.currentGear == 0):
		acceleration *= -1;

	var rpm = backLeft.get_rpm();
	backLeft.engine_force = acceleration * maxTorque * (1 - rpm / maxRPM);

	rpm = backRight.get_rpm();
	backRight.engine_force = acceleration * maxTorque * (1 - rpm / maxRPM);

	var brake : float = Input.get_action_strength(brakeInput + str(playerCount))

	frontLeft.brake = brakeForce * brake;
	frontRight.brake = brakeForce * brake;
	backLeft.brake = brakeForce * brake;
	backRight.brake = brakeForce * brake;

	if (Input.is_action_pressed(handbrakeInput + str(playerCount))):
		backLeft.engine_force = 0;
		backLeft.brake = brakeForce;
		backRight.engine_force = 0;
		backRight.brake = brakeForce;
