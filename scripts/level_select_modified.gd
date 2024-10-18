extends Control

# NOTE: Call in nodes
var tff_finished = false
var tff_ready = true
var tff_locked = false

var tmm_finished = false
var tmm_ready = false
var tmm_locked = true

var tdd_finished = false
var tdd_ready = false
var tdd_locked = true

var trt_finished = false
var trt_ready = false
var trt_locked = true

var tfc_finished = false
var tfc_ready = false
var tfc_locked = true

#TFF
var tff_btn # main button
var lt_tff # level title
var sb_tff # start button
var li_tff # lock image
var ci_tff # check image 
var go_tff # go button

#TMM
var tmm_btn # main button
var lt_tmm # level title
var sb_tmm # start button
var li_tmm # lock image
var ci_tmm # check image
var go_tmm # go button

#TDD
var tdd_btn # main button
var lt_tdd # level title
var sb_tdd # start button
var li_tdd # lock image
var ci_tdd # check image
var go_tdd # go button

#TRT
var trt_btn # main button
var lt_trt # level title
var sb_trt # start button
var li_trt # lock image
var ci_trt # check image
var go_trt # go button

#TFC
var tfc_btn # main button
var lt_tfc # level title
var sb_tfc # start button
var li_tfc # lock image
var ci_tfc # check image
var go_tfc # go button

var animation_player
var player_idol

#transition
@onready var transition = $Transition

#levels
var level1 = preload("res://scenes/level_1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#Animation player
	animation_player = $AnimationPlayer
	
	#Player idol
	player_idol = $MarginContainer/HBoxContainer/PlayerIdol
	
	#TFF
	tff_btn = $MarginContainer/HBoxContainer/TFF # main button
	lt_tff = $MarginContainer/HBoxContainer/TFF/LevelTitleTFF # level title
	sb_tff = $MarginContainer/HBoxContainer/TFF/StartBtnTFF # start button
	li_tff = $MarginContainer/HBoxContainer/TFF/LockImgTFF # lock image
	ci_tff = $MarginContainer/HBoxContainer/TFF/CheckImgTFF # check image 
	go_tff = $MarginContainer/HBoxContainer/TFF/GoTFF # go button
	
	#TMM
	tmm_btn = $MarginContainer/HBoxContainer/TMM # main button
	lt_tmm = $MarginContainer/HBoxContainer/TMM/LevelTitleTMM # level title
	sb_tmm = $MarginContainer/HBoxContainer/TMM/StartBtnTMM # start button
	li_tmm = $MarginContainer/HBoxContainer/TMM/LockImgTMM # lock image
	ci_tmm = $MarginContainer/HBoxContainer/TMM/CheckImgTMM # check image
	go_tmm = $MarginContainer/HBoxContainer/TMM/GoTMM # go button
	
	#TDD
	tdd_btn = $MarginContainer/HBoxContainer/TDD # main button
	lt_tdd = $MarginContainer/HBoxContainer/TDD/LevelTitleTDD # level title
	sb_tdd = $MarginContainer/HBoxContainer/TDD/StartBtnTDD # start button
	li_tdd = $MarginContainer/HBoxContainer/TDD/LockImgTDD # lock image
	ci_tdd = $MarginContainer/HBoxContainer/TDD/CheckImgTDD # check image
	go_tdd = $MarginContainer/HBoxContainer/TDD/GoTDD # go button
	
	#TRT
	trt_btn = $MarginContainer/HBoxContainer/TRT # main button
	lt_trt = $MarginContainer/HBoxContainer/TRT/LevelTitleTRT # level title
	sb_trt = $MarginContainer/HBoxContainer/TRT/StartBtnTRT # start button
	li_trt = $MarginContainer/HBoxContainer/TRT/LockImgTRT # lock image
	ci_trt = $MarginContainer/HBoxContainer/TRT/CheckImgTRT # check image
	go_trt = $MarginContainer/HBoxContainer/TRT/GoTRT # go button
	
	#TFC
	tfc_btn = $MarginContainer/HBoxContainer/TFC # main button
	lt_tfc = $MarginContainer/HBoxContainer/TFC/LevelTitleTFC # level title
	sb_tfc = $MarginContainer/HBoxContainer/TFC/StartBtnTFC # start button
	li_tfc = $MarginContainer/HBoxContainer/TFC/LockImgTFC # lock image
	ci_tfc = $MarginContainer/HBoxContainer/TFC/CheckImgTFC # check image
	go_tfc = $MarginContainer/HBoxContainer/TFC/GoTFC # go button
	
	check_status()

func check_status() -> void:
	tff_status()
	tmm_status()
	tdd_status()
	trt_status()
	tfc_status()

# NOTE: Open, checked, and locked buttons
func simulate_hover(button):
	var normal_texture = button.texture_normal
	button.texture_normal = button.texture_hover
	button.texture_hover = normal_texture

#TFF ----------------------------------------------------------------
func open_tff() -> void:
	sb_tff.show()
	li_tff.hide()
	ci_tff.hide()
	go_tff.hide()
	simulate_hover(tff_btn)

func check_tff() -> void:
	sb_tff.hide()
	li_tff.hide()
	ci_tff.show()
	go_tff.hide()

func lock_tff() -> void:
	sb_tff.hide()
	li_tff.show()
	ci_tff.hide()
	go_tff.hide()
	
#TMM ----------------------------------------------------------------
func open_tmm() -> void:
	sb_tmm.show()
	li_tmm.hide()
	ci_tmm.hide()
	go_tmm.hide()
	simulate_hover(tmm_btn)

func check_tmm() -> void:
	sb_tmm.hide()
	li_tmm.hide()
	ci_tmm.show()
	go_tmm.hide()

func lock_tmm() -> void:
	sb_tmm.hide()
	li_tmm.show()
	ci_tmm.hide()
	go_tmm.hide()

#TDD ----------------------------------------------------------------
func open_tdd() -> void:
	sb_tdd.show()
	li_tdd.hide()
	ci_tdd.hide()
	go_tdd.hide()
	simulate_hover(tdd_btn)

func check_tdd() -> void:
	sb_tdd.hide()
	li_tdd.hide()
	ci_tdd.show()
	go_tdd.hide()

func lock_tdd() -> void:
	sb_tdd.hide()
	li_tdd.show()
	ci_tdd.hide()
	go_tdd.hide()

#TRT ----------------------------------------------------------------
func open_trt() -> void:
	sb_trt.show()
	li_trt.hide()
	ci_trt.hide()
	go_trt.hide()
	simulate_hover(trt_btn)

func check_trt() -> void:
	sb_trt.hide()
	li_trt.hide()
	ci_trt.show()
	go_trt.hide()

func lock_trt() -> void:
	sb_trt.hide()
	li_trt.show()
	ci_trt.hide()
	go_trt.hide()

#TFC ----------------------------------------------------------------
func open_tfc() -> void:
	sb_tfc.show()
	li_tfc.hide()
	ci_tfc.hide()
	go_tfc.hide()
	simulate_hover(tfc_btn)

func check_tfc() -> void:
	sb_tfc.hide()
	li_tfc.hide()
	ci_tfc.show()
	go_tfc.hide()

func lock_tfc() -> void:
	sb_tfc.hide()
	li_tfc.show()
	ci_tfc.hide()
	go_tfc.hide()

# NOTE: Is current level or not: Status
func tff_status() -> void:
	if (tff_locked == true):
		lock_tff()
	elif (tff_ready == true):
		lock_tff()
		go_tff.show()
		go_tff.modulate = Color(1, 1, 1, 0)
		animation_player.play("FadeIn_GoBtn")

func tmm_status() -> void:
	if (tmm_locked == true):
		lock_tmm()
	elif (tmm_ready == true):
		lock_tmm()
		go_tmm.show()
		go_tmm.modulate = Color(1, 1, 1, 0)
		await wait_for_seconds(0.2)
		animation_player.play("FadeIn_GoBtn")

func tdd_status() -> void:
	if (tdd_locked == true):
		lock_tdd()
	elif (tdd_ready == true):
		lock_tdd()
		go_tdd.show()
		go_tdd.modulate = Color(1, 1, 1, 0)
		await wait_for_seconds(0.2)
		animation_player.play("FadeIn_GoBtn")

func trt_status() -> void:
	if (trt_locked == true):
		lock_trt()
	elif (trt_ready == true):
		lock_trt()
		go_trt.show()
		go_trt.modulate = Color(1, 1, 1, 0)
		await wait_for_seconds(0.2)
		animation_player.play("FadeIn_GoBtn")
		
func tfc_status() -> void:
	if (tfc_locked == true):
		lock_tfc()
	elif (tfc_ready == true):
		lock_tfc()
		go_tfc.show()
		go_tfc.modulate = Color(1, 1, 1, 0)
		await wait_for_seconds(0.2)
		animation_player.play("FadeIn_GoBtn")

# NOTE: Go buttons
func _on_go_tff_pressed() -> void:
	animation_player.play("BreakLock_TFF")
	await wait_for_seconds(1.3)
	open_tff()
	player_idol.visible = true
	player_idol.modulate = Color(1, 1, 1, 0)
	animation_player.play("charEnter")
	player_idol.play("walkingAnimation")
	await wait_for_seconds(1)
	player_idol.play("idleAnimation")
	await wait_for_seconds(0.3)
	animation_player.play("FadeIn_StartBtn")

func _on_go_tmm_pressed() -> void:
	animation_player.play("BreakLock_TMM")
	await wait_for_seconds(1.3)
	open_tmm()
	animation_player.play("charEnter_2")
	player_idol.play("walkingAnimation")
	await wait_for_seconds(1)
	player_idol.play("idleAnimation")
	check_tff()
	animation_player.play("CheckMark_TFF")
	await wait_for_seconds(0.3)
	animation_player.play("FadeIn_StartBtn")

func _on_go_tdd_pressed() -> void:
	animation_player.play("BreakLock_TDD")
	await wait_for_seconds(1.3)
	open_tdd()
	animation_player.play("charEnter_3")
	player_idol.play("walkingAnimation")
	await wait_for_seconds(1)
	player_idol.play("idleAnimation")
	check_tmm()
	animation_player.play("CheckMark_TMM")
	await wait_for_seconds(0.3)
	animation_player.play("FadeIn_StartBtn")

func _on_go_trt_pressed() -> void:
	animation_player.play("BreakLock_TRT")
	await wait_for_seconds(1.3)
	open_trt()
	animation_player.play("charEnter_4")
	player_idol.play("walkingAnimation")
	await wait_for_seconds(1)
	player_idol.play("idleAnimation")
	check_tdd()
	animation_player.play("CheckMark_TDD")
	await wait_for_seconds(0.3)
	animation_player.play("FadeIn_StartBtn")

func _on_go_tfc_pressed() -> void:
	animation_player.play("BreakLock_TFC")
	await wait_for_seconds(1.3)
	open_tfc()
	animation_player.play("charEnter_5")
	player_idol.play("walkingAnimation")
	await wait_for_seconds(1)
	player_idol.play("idleAnimation")
	check_trt()
	animation_player.play("CheckMark_TRT")
	await wait_for_seconds(0.3)
	animation_player.play("FadeIn_StartBtn")

# NOTE: Start buttons
func _on_start_btn_tff_pressed() -> void:
	#stuff for changing scenes
	transition.play("fade2level")
	
	tff_finished = true
	tff_ready = false
	tff_locked = false
	tmm_finished = false
	tmm_ready = true
	tmm_locked = false
	animation_player.play("FadeOut_StartBtn")
	await wait_for_seconds(1)
	check_status()
	

func _on_start_btn_tmm_pressed() -> void:
	tmm_finished = true
	tmm_ready = false
	tmm_locked = false
	tdd_finished = false
	tdd_ready = true
	tdd_locked = false
	animation_player.play("FadeOut_StartBtn")
	await wait_for_seconds(1)
	check_status()
	#get_tree().change_scene_to_file("res://scenes/TMM_MAP.tscn")

func _on_start_btn_tdd_pressed() -> void:
	tdd_finished = true
	tdd_ready = false
	tdd_locked = false
	trt_finished = false
	trt_ready = true
	trt_locked = false
	animation_player.play("FadeOut_StartBtn")
	await wait_for_seconds(1)
	check_status()
	#get_tree().change_scene_to_file("res://scenes/TDD_MAP.tscn")

func _on_start_btn_trt_pressed() -> void:
	trt_finished = true
	trt_ready = false
	trt_locked = false
	tfc_finished = false
	tfc_ready = true
	tfc_locked = false
	animation_player.play("FadeOut_StartBtn")
	await wait_for_seconds(1)
	check_status()
	#get_tree().change_scene_to_file("res://scenes/TRT_MAP.tscn")

func _on_start_btn_tfc_pressed() -> void:
	tfc_finished = true
	tfc_ready = false
	tfc_locked = false
	animation_player.play("FadeOut_StartBtn")
	await wait_for_seconds(1)
	check_status()
	#get_tree().change_scene_to_file("res://scenes/TFC_MAP.tscn")
	
	"""
	NOTE:
		Please move the check marks on a different function
		Function identifier which runs if game is level is completed
	"""
	
	await wait_for_seconds(3)
	check_tfc()
	animation_player.play("CheckMark_TFC")

# NOTE: wait function
func wait_for_seconds(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout


"""
NOTE:
	Please move the check marks on different functions
	Function identifier which runs if game level is completed
	
	Additionally:
		Start button should not fade, or better, move to the same identifier function
		All check marks and start button animations/transitions is temporary placed
	
	Furthermore:
		Check what to do to player idol in last level/scene
		Transition out or something
"""


func _on_back_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/home_screen.tscn")


func _on_transition_animation_finished(anim_name):
	if(anim_name == "fade2level"):
		get_tree().change_scene_to_packed(level1)
