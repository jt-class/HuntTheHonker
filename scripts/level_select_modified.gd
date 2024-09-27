extends Control

# NOTE: Call in nodes
var tff_finished = false
var tff_ready = true
var tff_locked = false

var tmm_finished = false
var tmm_ready = false
var tmm_locked = true

var trt_finished = false
var trt_ready = false
var trt_locked = true

var tfc_finished = false
var tfc_ready = false
var tfc_locked = true

#TFF
var tff_btn # main button
var pi_tff # player idol
var lt_tff # level title
var sb_tff # start button
var li_tff # lock image
var ci_tff # check image 
var go_tff # go button

#TMM
var tmm_btn # main button
var pi_tmm # player idol
var lt_tmm # level title
var sb_tmm # start button
var li_tmm # lock image
var ci_tmm # check image
var go_tmm # go button

#TRT
var trt_btn # main button
var pi_trt # player idol
var lt_trt # level title
var sb_trt # start button
var li_trt # lock image
var ci_trt # check image
var go_trt # go button

#TFC
var tfc_btn # main button
var pi_tfc # player idol
var lt_tfc # level title
var sb_tfc # start button
var li_tfc # lock image
var ci_tfc # check image
var go_tfc # go button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#TFF
	tff_btn = $MarginContainer/HBoxContainer/TFF # main button
	pi_tff = $MarginContainer/HBoxContainer/TFF/PlayerIdolTFF # player idol
	lt_tff = $MarginContainer/HBoxContainer/TFF/LevelTitleTFF # level title
	sb_tff = $MarginContainer/HBoxContainer/TFF/StartBtnTFF # start button
	li_tff = $MarginContainer/HBoxContainer/TFF/LockImgTFF # lock image
	ci_tff = $MarginContainer/HBoxContainer/TFF/CheckImgTFF # check image 
	go_tff = $MarginContainer/HBoxContainer/TFF/GoTFF # go button
	
	#TMM
	tmm_btn = $MarginContainer/HBoxContainer/TMM # main button
	pi_tmm = $MarginContainer/HBoxContainer/TMM/PlayerIdolTMM # player idol
	lt_tmm = $MarginContainer/HBoxContainer/TMM/LevelTitleTMM # level title
	sb_tmm = $MarginContainer/HBoxContainer/TMM/StartBtnTMM # start button
	li_tmm = $MarginContainer/HBoxContainer/TMM/LockImgTMM # lock image
	ci_tmm = $MarginContainer/HBoxContainer/TMM/CheckImgTMM # check image
	go_tmm = $MarginContainer/HBoxContainer/TMM/GoTMM # go button
	
	#TRT
	trt_btn = $MarginContainer/HBoxContainer/TRT # main button
	pi_trt = $MarginContainer/HBoxContainer/TRT/PlayerIdolTRT # player idol
	lt_trt = $MarginContainer/HBoxContainer/TRT/LevelTitleTRT # level title
	sb_trt = $MarginContainer/HBoxContainer/TRT/StartBtnTRT # start button
	li_trt = $MarginContainer/HBoxContainer/TRT/LockImgTRT # lock image
	ci_trt = $MarginContainer/HBoxContainer/TRT/CheckImgTRT # check image
	go_trt = $MarginContainer/HBoxContainer/TRT/GoTRT # go button
	
	#TFC
	tfc_btn = $MarginContainer/HBoxContainer/TFC # main button
	pi_tfc = $MarginContainer/HBoxContainer/TFC/PlayerIdolTFC # player idol
	lt_tfc = $MarginContainer/HBoxContainer/TFC/LevelTitleTFC # level title
	sb_tfc = $MarginContainer/HBoxContainer/TFC/StartBtnTFC # start button
	li_tfc = $MarginContainer/HBoxContainer/TFC/LockImgTFC # lock image
	ci_tfc = $MarginContainer/HBoxContainer/TFC/CheckImgTFC # check image
	go_tfc = $MarginContainer/HBoxContainer/TFC/GoTFC # go button
	
	check_status()

func check_status() -> void:
	tff_status()
	tmm_status()
	trt_status()
	tfc_status()

# NOTE: Open, checked, and locked buttons
func simulate_hover(button):
	var hover_style = button.get_theme_stylebox("hover")
	button.add_theme_stylebox_override("normal", hover_style)

#TFF ----------------------------------------------------------------
func open_tff() -> void:
	pi_tff.show()
	sb_tff.show()
	li_tff.hide()
	ci_tff.hide()
	go_tff.hide()
	simulate_hover(tff_btn)

func check_tff() -> void:
	pi_tff.hide()
	sb_tff.hide()
	li_tff.hide()
	ci_tff.show()
	go_tff.hide()

func lock_tff() -> void:
	pi_tff.hide()
	sb_tff.hide()
	li_tff.show()
	ci_tff.hide()
	go_tff.hide()
	
#TMM ----------------------------------------------------------------
func open_tmm() -> void:
	pi_tmm.show()
	sb_tmm.show()
	li_tmm.hide()
	ci_tmm.hide()
	go_tmm.hide()
	simulate_hover(tmm_btn)

func check_tmm() -> void:
	pi_tmm.hide()
	sb_tmm.hide()
	li_tmm.hide()
	ci_tmm.show()
	go_tmm.hide()

func lock_tmm() -> void:
	pi_tmm.hide()
	sb_tmm.hide()
	li_tmm.show()
	ci_tmm.hide()
	go_tmm.hide()

#TRT ----------------------------------------------------------------
func open_trt() -> void:
	pi_trt.show()
	sb_trt.show()
	li_trt.hide()
	ci_trt.hide()
	go_trt.hide()
	simulate_hover(trt_btn)

func check_trt() -> void:
	pi_trt.hide()
	sb_trt.hide()
	li_trt.hide()
	ci_trt.show()
	go_trt.hide()

func lock_trt() -> void:
	pi_trt.hide()
	sb_trt.hide()
	li_trt.show()
	ci_trt.hide()
	go_trt.hide()

#TFC ----------------------------------------------------------------
func open_tfc() -> void:
	pi_tfc.show()
	sb_tfc.show()
	li_tfc.hide()
	ci_tfc.hide()
	go_tfc.hide()
	simulate_hover(tfc_btn)

func check_tfc() -> void:
	pi_tfc.hide()
	sb_tfc.hide()
	li_tfc.hide()
	ci_tfc.show()
	go_tfc.hide()

func lock_tfc() -> void:
	pi_tfc.hide()
	sb_tfc.hide()
	li_tfc.show()
	ci_tfc.hide()
	go_tfc.hide()

# NOTE: Is current level or not: Status
func tff_status() -> void:
	if (tff_finished == true):
		check_tff()
	elif (tff_locked == true):
		lock_tff()
	elif (tff_ready == true):
		lock_tff()
		go_tff.show()
		
	print(tff_finished)
	print(tff_locked)
	print(tff_ready)

func tmm_status() -> void:
	if (tmm_finished == true):
		check_tmm()
	elif (tmm_locked == true):
		lock_tmm()
	elif (tmm_ready == true):
		lock_tmm()
		go_tmm.show()
		
	print(tmm_finished)
	print(tmm_locked)
	print(tmm_ready)
	
func trt_status() -> void:
	if (trt_finished == true):
		check_trt()
	elif (trt_locked == true):
		lock_trt()
	elif (trt_ready == true):
		lock_trt()
		go_trt.show()
		
func tfc_status() -> void:
	if (tfc_finished == true):
		check_tfc()
	elif (tfc_locked == true):
		lock_tfc()
	elif (tfc_ready == true):
		lock_tfc()
		go_tfc.show()

# NOTE: Go buttons
func _on_go_tff_pressed() -> void:
	open_tff()

func _on_go_tmm_pressed() -> void:
	open_tmm()

func _on_go_trt_pressed() -> void:
	open_trt()

func _on_go_tfc_pressed() -> void:
	open_tfc()

# NOTE: Start buttons
func _on_start_btn_tff_pressed() -> void:
	tff_finished = true
	tff_ready = false
	tff_locked = false
	tmm_finished = false
	tmm_ready = true
	tmm_locked = false
	check_tff() # temporary, replace with Euree's navigation logic
	check_status()
	get_tree().change_scene_to_file("res://scenes/TFF_MAP.tscn")

func _on_start_btn_tmm_pressed() -> void:
	tmm_finished = true
	tmm_ready = false
	tmm_locked = false
	trt_finished = false
	trt_ready = true
	trt_locked = false
	check_tmm() # temporary, replace with Euree's navigation logic
	check_status()
	get_tree().change_scene_to_file("res://scenes/TMM_MAP.tscn")

func _on_start_btn_trt_pressed() -> void:
	trt_finished = true
	trt_ready = false
	trt_locked = false
	tfc_finished = false
	tfc_ready = true
	tfc_locked = false
	check_trt() # temporary, replace with Euree's navigation logic
	check_status()
	get_tree().change_scene_to_file("res://scenes/TRT_MAP.tscn")

func _on_start_btn_tfc_pressed() -> void:
	tfc_finished = true
	tfc_ready = false
	tfc_locked = false
	check_tfc() # temporary, replace with Euree's navigation logic
	check_status()
	get_tree().change_scene_to_file("res://scenes/TFC_MAP.tscn")
