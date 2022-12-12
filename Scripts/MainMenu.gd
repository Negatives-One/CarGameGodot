extends Control

var levelToLoad : String
var loading : ResourceInteractiveLoader
var stageCount : int

func _ready():
	set_process(false)

func _process(_delta : float) -> void:
	var progress : int = loading.poll()
	$LoadingPanel/ProgressBar.value = float(loading.get_stage()) / float(stageCount)
	if progress == ERR_FILE_EOF:
		$LoadingPanel/Continue.visible = true
		$LoadingPanel/ProgressBar.value = 1.0
	if progress == ERR_FILE_EOF && Input.is_action_just_pressed("Handbrake1"):
		$LoadingPanel/Timer.start()
		set_process(false)

func _on_Timer_timeout():
	var _changeError : int = get_tree().change_scene_to(loading.get_resource())


func _on_Singleplayer_pressed():
	$PlayerSelection.visible = false
	$Control/SingleplayerOptions.visible = true
	$Back.visible = true


func _on_Sliptscreen_pressed():
	$PlayerSelection.visible = false
	$Control/MultiplayerOptions.visible = true
	$Back.visible = true


func _on_Back_pressed():
	$PlayerSelection.visible = true
	$Control/SingleplayerOptions.visible = false
	$Control/MultiplayerOptions.visible = false
	$Back.visible = false


func _on_Singleplayer_Level_3_pressed():
	levelToLoad = "res://Track3.tscn"
	loading = ResourceLoader.load_interactive(levelToLoad)
	stageCount = loading.get_stage_count()
	$LoadingPanel.visible = true
	set_process(true)

func _on_Singleplayer_Level_2_pressed():
	levelToLoad = "res://Track2.tscn"
	loading = ResourceLoader.load_interactive(levelToLoad)
	stageCount = loading.get_stage_count()
	$LoadingPanel.visible = true
	set_process(true)

func _on_Singleplayer_Level_1_pressed():
	levelToLoad = "res://MainScene.tscn"
	loading = ResourceLoader.load_interactive(levelToLoad)
	stageCount = loading.get_stage_count()
	$LoadingPanel.visible = true
	set_process(true)

func _on_Multiplayer_Level_1_pressed():
	levelToLoad = "res://MultiplayerTracks/MainSceneSC.tscn"
	loading = ResourceLoader.load_interactive(levelToLoad)
	stageCount = loading.get_stage_count()
	$LoadingPanel.visible = true
	set_process(true)

func _on_Multiplayer_Level_2_pressed():
	levelToLoad = "res://MultiplayerTracks/Track2SC.tscn"
	loading = ResourceLoader.load_interactive(levelToLoad)
	stageCount = loading.get_stage_count()
	$LoadingPanel.visible = true
	set_process(true)
