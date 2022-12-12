extends Spatial

var radian : float = 0
var ray : float = 100
var pointsCount : int = 50
onready var stepRadian : float = (PI*2) / pointsCount

var rectSize : Vector2 = Vector2(200, 100)
onready var stepRect : float = rectSize.x / pointsCount

export(NoiseTexture) var noiseTexture : NoiseTexture

func _ready():
	GenerateTrack()

func _process(delta):
	if(Input.is_key_pressed(KEY_W)):
		GenerateTrack()

func GenerateTrack() -> void:
	randomize()
	var curve : Curve3D = Curve3D.new()
	var points : Array
	noiseTexture.noise.seed = randi()
	#Circle Behavior
#	for i in range(pointsCount+1):
#		randomize()
#		var pos : Vector3 = Vector3(sin(radian) * (ray * rand_range(0.0, 1.0)), 0.0, cos(radian) * (ray * rand_range(0.0, 1.0)))
#		radian += stepRadian
#		points.append(pos)

	for i in range(pointsCount+1):
		#randomize()
		var pos : Vector3 = Vector3(float(i) * stepRect - 100.0, 0.0, rectSize.y * noiseTexture.noise.get_noise_1d(float(i) * stepRect))
		points.append(pos)
	
	for i in range(500):
		curve.add_point(InfiniteCubicCurve(points, float(i) / 500.0))
	
	$Path.curve = curve

func InfiniteCubicCurve(pts : Array, t : float) -> Vector3:
	var n = pts.size()
	if (n == 0):
		return Vector3(0, 0, 0)
	if (n==1):
		var p1 : Vector3 = pts[0]
		return p1
	else:
		var newPoints : Array
		for i in range(1, pts.size()):
			var p1 : Vector3 = pts[i-1]
			var p2 : Vector3 = pts[i]
			newPoints.append(Vector3(p1.x+t*(p2.x-p1.x), 0.0, p1.z+t*(p2.z-p1.z)))
		return InfiniteCubicCurve(newPoints, t);
