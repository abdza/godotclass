extends Node2D
var select = 1
var transition = false
var tranum = 0
var locate = false
var locate2 = false
var locatenum = 0
var locatenum2y = 0
var locatenum2x = 0
var delay = 0
var ymove = 0
var xmove = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	var startmouse = false
	var changemouse = false
	var quitmouse = false
	var chassismouse = false
	var weaponmouse = false
	var chassismouse2 = false
	var weaponmouse2 = false
	var centerx = get_viewport().size.x / 2
	var centery = get_viewport().size.y / 2
	var scaleupx = get_viewport().size.x
	var scaleupy = get_viewport().size.y
	#var SC01 = 0.00009765625 * scaleupx
	#var SC011 = 0.000107421875 * scaleupx
	#var sc = 0.0000048828125 * scaleupx
	#var SCnodex = 0.0009765625 * scaleupx
	#var SCnodey = 0.00166666666666666666666666666667 * scaleupy
	
#	if SCnodex < SCnodey + 0.2:
#		scale.x = SCnodex
#		scale.y = SCnodex
	
	
	if select == 1:
		ymove -= 10
	if select == 2:
		ymove += 10
	if $quit.rect_position.y > centery:
		ymove += 10
	if $quit.rect_position.y < 0 - 100:
		ymove -= 10
	if tranum > 0:
		transition = true
		tranum -= 1
	if tranum == 0:
		transition = false
	#debug code
	#print(get_viewport().size.x)
	#print(get_viewport().size.y)
	
	$play.rect_position.x = centerx
	$play.rect_position.y = centery - 40 - ymove
	$change.rect_position.x = centerx 
	$change.rect_position.y = centery - 5 - ymove
	$quit.rect_position.x = centerx
	$quit.rect_position.y = centery + 40 - ymove
	$Armory.position.x = get_viewport().size.x
	$Armory.position.y = get_viewport().size.y + 600 - ymove * 1.4
	if $Armory.position.y < get_viewport().size.y and transition:
		$Armory.position.y = get_viewport().size.y - 1
	if !transition and select == 2:
		$Armory.position.y = get_viewport().size.y - 1
	$chassisarmory.rect_position.x = $Armory.position.x - 450
	$chassisarmory.rect_position.y = $Armory.position.y - 500
	$weaponarmory.rect_position.x = $Armory.position.x - 150
	$weaponarmory.rect_position.y = $Armory.position.y - 500
	$strder2.position.x = $chassisarmory.rect_position.x + 20
	$strder2.position.y = $chassisarmory.rect_position.y + 100
	$oger2.position.x = $chassisarmory.rect_position.x + 20
	$oger2.position.y = $chassisarmory.rect_position.y + 250
	$lazer2.position.x = $weaponarmory.rect_position.x + 20
	$lazer2.position.y = $weaponarmory.rect_position.y + 100
	$cannon2.position.x = $weaponarmory.rect_position.x + 20
	$cannon2.position.y = $weaponarmory.rect_position.y + 250
	
	if select == 1 and transition == false:
		$base.position.x = centerx
		$base.position.y = centery + 150
	if select == 1 and transition == true:
		if $base.position.x > centerx:
			$base.position.x -= 5
		if $base.position.x < centerx:
			$base.position.x += 5
		if $base.position.y > centery + 150:
			$base.position.y -= 5
		if $base.position.y < centery + 150:
			$base.position.y += 5
	if select == 2 and transition == false:
		$base.position.x = centerx - 250
		$base.position.y = centery
	if select == 2 and transition == true:
		if $base.position.x > centerx - 250:
			$base.position.x -= 5
		if $base.position.x < centerx - 250:
			$base.position.x += 5
		if $base.position.y > centery:
			$base.position.y -= 5
		if $base.position.y < centery:
			$base.position.y += 5
		
		
	if Global.chassis == 1:
		$strder.position.x = $base.position.x
		$strder.position.y = $base.position.y
		$oger.position.x = -1000
			
		
	if Global.chassis == 2:
		$oger.position.x = $base.position.x
		$oger.position.y = $base.position.y
		$strder.position.x = -1000
			
		
			
	if Global.weapon == 1:
		$lazer.position.x = $base.position.x
		$lazer.position.y = $base.position.y
		$cannon.position.x = -1000
	if Global.weapon == 2:
		$cannon.position.x = $base.position.x
		$cannon.position.y = $base.position.y
		$lazer.position.x = -1000
	if select == 1:
		if !transition:
			$strder.scale.x = 0.1
			$strder.scale.y = 0.1
			$lazer.scale.x = 0.1
			$lazer.scale.y = 0.1
			$oger.scale.x = 0.1
			$oger.scale.y = 0.1
			$cannon.scale.x = 0.11
			$cannon.scale.y = 0.11
		if transition:
			if $strder.scale.x > 0.1:
				$strder.scale.x -= 0.005
			if $strder.scale.x < 0.1:
				$strder.scale.x = 0.1
			if $strder.scale.y > 0.1:
				$strder.scale.y -= 0.005
			if $strder.scale.y < 0.1:
				$strder.scale.y = 0.1
			
			if $oger.scale.x > 0.1:
				$oger.scale.x -= 0.005
			if $oger.scale.x < 0.1:
				$oger.scale.x = 0.1
			if $oger.scale.y > 0.1:
				$oger.scale.y -= 0.005
			if $oger.scale.y < 0.1:
				$oger.scale.y = 0.1
			
			if $lazer.scale.x > 0.1:
				$lazer.scale.x -= 0.005
			if $lazer.scale.x < 0.1:
				$lazer.scale.x = 0.1
			if $lazer.scale.y > 0.1:
				$lazer.scale.y -= 0.005
			if $lazer.scale.y < 0.1:
				$lazer.scale.y = 0.1
			
			if $cannon.scale.x > 0.1:
				$cannon.scale.x -= 0.005
			if $cannon.scale.x < 0.11:
				$cannon.scale.x = 0.11
			if $cannon.scale.y > 0.11:
				$cannon.scale.y -= 0.005
			if $cannon.scale.y < 0.11:
				$cannon.scale.y = 0.11
	if select == 2:
		if !transition:
			$strder.scale.x = 0.1 * 3
			$strder.scale.y = 0.1 * 3
			$lazer.scale.x = 0.1 * 3
			$lazer.scale.y = 0.1 * 3
			$oger.scale.x = 0.1 * 3
			$oger.scale.y = 0.1 * 3
			$cannon.scale.x = 0.11 * 3
			$cannon.scale.y = 0.11 * 3
		if transition:
			if $strder.scale.x > 0.1 * 3:
				$strder.scale.x = 0.1 * 3
			if $strder.scale.x < 0.1 * 3:
				$strder.scale.x += 0.005
			if $strder.scale.y > 0.1 * 3:
				$strder.scale.y = 0.1 * 3
			if $strder.scale.y < 0.1 * 3:
				$strder.scale.y += 0.005
				
			if $oger.scale.x > 0.1 * 3:
				$oger.scale.x = 0.1 * 3
			if $oger.scale.x < 0.1 * 3:
				$oger.scale.x += 0.005
			if $oger.scale.y > 0.1 * 3:
				$oger.scale.y = 0.1 * 3
			if $oger.scale.y < 0.1 * 3:
				$oger.scale.y += 0.005
			
			if $lazer.scale.x > 0.1 * 3:
				$lazer.scale.x = 0.1 * 3
			if $lazer.scale.x < 0.1 * 3:
				$lazer.scale.x += 0.005
			if $lazer.scale.y > 0.1 * 3:
				$lazer.scale.y = 0.1 * 3
			if $lazer.scale.y < 0.1 * 3:
				$lazer.scale.y += 0.005
			
			if $cannon.scale.x > 0.11 * 3:
				$cannon.scale.x = 0.11 * 3
			if $cannon.scale.x < 0.11 * 3:
				$cannon.scale.x += 0.005
			if $cannon.scale.y > 0.11 * 3:
				$cannon.scale.y = 0.11 * 3
			if $cannon.scale.y < 0.11 * 3:
				$cannon.scale.y += 0.005
	
	
	
	
	
	
	if select == 1:
		if get_global_mouse_position().x < $play.rect_position.x + 40 and get_global_mouse_position().x > $play.rect_position.x - 40 \
		and get_global_mouse_position().y < $play.rect_position.y + 15 and get_global_mouse_position().y > $play.rect_position.y - 15 and !transition:
			locate = true
			locatenum = 1
			startmouse = true
		if get_global_mouse_position().x < $change.rect_position.x + 80 and get_global_mouse_position().x > $change.rect_position.x - 80 \
		and get_global_mouse_position().y < $change.rect_position.y + 15 and get_global_mouse_position().y > $change.rect_position.y - 15 and !transition:
			locate = true
			locatenum = 2
			changemouse = true
		if get_global_mouse_position().x < $quit.rect_position.x + 40 and get_global_mouse_position().x > $quit.rect_position.x - 40 \
		and get_global_mouse_position().y < $quit.rect_position.y + 15 and get_global_mouse_position().y > $quit.rect_position.y - 15 and !transition:
			locate = true
			locatenum = 3
			quitmouse = true
	if select == 2:
		if get_global_mouse_position().x < $strder2.position.x + 80 and get_global_mouse_position().x > $strder2.position.x - 80 \
		and get_global_mouse_position().y < $strder2.position.y + 80 and get_global_mouse_position().y > $strder2.position.y - 80 and !transition:
			locate2 = true
			locatenum2x = 1
			locatenum2y = 1
			chassismouse = true
		if get_global_mouse_position().x < $oger2.position.x + 70 and get_global_mouse_position().x > $oger2.position.x - 70 \
		and get_global_mouse_position().y < $oger2.position.y + 80 and get_global_mouse_position().y > $oger2.position.y - 80 and !transition:
			locate2 = true
			locatenum2x = 1
			locatenum2y = 2
			chassismouse2 = true
		if get_global_mouse_position().x < $lazer2.position.x + 40 and get_global_mouse_position().x > $lazer2.position.x - 40 \
		and get_global_mouse_position().y < $lazer2.position.y + 60 and get_global_mouse_position().y > $lazer2.position.y - 60 and !transition:
			locate2 = true
			locatenum2x = 2
			locatenum2y = 1
			weaponmouse = true
		if get_global_mouse_position().x < $cannon2.position.x + 40 and get_global_mouse_position().x > $cannon2.position.x - 40 \
		and get_global_mouse_position().y < $cannon2.position.y + 80 and get_global_mouse_position().y > $cannon2.position.y - 80 and !transition:
			locate2 = true
			locatenum2x = 2
			locatenum2y = 2
			weaponmouse2 = true
	if select == 1:
		if Input.is_key_pressed(KEY_DOWN) and delay <= 0 and !transition:
			locate = true
			locatenum += 1
			delay = 8
		if Input.is_key_pressed(KEY_UP) and delay <= 0 and !transition:
			locatenum -= 1
			delay = 8
	if select == 2:
		if Input.is_key_pressed(KEY_RIGHT) and delay <= 0 and !transition:
			if locate2 == true:
				locatenum2x += 1
				delay = 8
			if locate2 == false:
				locate2 = true
				locatenum2x = 2
				locatenum2y = 2
		if Input.is_key_pressed(KEY_UP) and delay <= 0 and !transition:
			if locate2 == true:
				locatenum2y -= 1
				delay = 8
			if locate2 == false:
				locate2 = true
				locatenum2x = 2
				locatenum2y = 1
		if Input.is_key_pressed(KEY_LEFT) and delay <= 0 and !transition:
			if locate2 == true:
				locatenum2x -= 1
				delay = 8
			if locate2 == false:
				locate2 = true
				locatenum2x = 1
				locatenum2y = 1
		if Input.is_key_pressed(KEY_DOWN) and delay <= 0 and !transition:
			if locate2 == true:
				locatenum2y += 1
				delay = 8
			if locate2 == false:
				locate2 = true
				locatenum2x = 1
				locatenum2y = 2
	if locate == true:
		if locatenum == 1:
			$arrow.position.x = $play.rect_position.x - 40
			$arrow.position.y = $play.rect_position.y + 2
		if locatenum == 2:
			$arrow.position.x = $change.rect_position.x - 40
			$arrow.position.y = $change.rect_position.y + 2
		if locatenum == 3:
			$arrow.position.x = $quit.rect_position.x - 40
			$arrow.position.y = $quit.rect_position.y + 2
	if locate == false:
		$arrow.position.x = -100
		$arrow.position.y = -100
	if locate2 == true:
		$strder2.scale.x = 0.2
		$strder2.scale.y = 0.2
		$oger2.scale.x = 0.2
		$oger2.scale.y = 0.2
		$lazer2.scale.x = 0.2
		$lazer2.scale.y = 0.2
		$cannon2.scale.x = 0.22
		$cannon2.scale.y = 0.22
		if locatenum2x == 1 and locatenum2y == 1:
			$strder2.scale.x = 0.25
			$strder2.scale.y = 0.25
		if locatenum2x == 1 and locatenum2y == 2:
			$oger2.scale.x = 0.25
			$oger2.scale.y = 0.25
		if locatenum2x == 2 and locatenum2y == 1:
			$lazer2.scale.x = 0.25
			$lazer2.scale.y = 0.25
		if locatenum2x == 2 and locatenum2y == 2:
			$cannon2.scale.x = 0.26
			$cannon2.scale.y = 0.26
	if select == 2:
		if locate2 == true and locatenum2x == 3:
			locatenum2x = 1
		if locate2 == true and locatenum2x == 0:
			locatenum2x = 2
		if locate2 == true and locatenum2y == 3:
			locatenum2y = 1
		if locate2 == true and locatenum2y == 0:
			locatenum2y = 2
		locatenum = 0
	if select == 1:
		if locate == true and locatenum == 4:
			locatenum = 1
		if locate == true and locatenum == 0:
			locatenum = 3
	
	if delay > 0:
		delay -= 1
	if select == 1 and locate == true:
		if locatenum == 1 and Input.is_key_pressed(KEY_ENTER) or startmouse == true and Input.is_mouse_button_pressed(1) and !transition:
			get_tree().change_scene("res://secne/selectscreen.tscn")
		if locatenum == 2 and Input.is_key_pressed(KEY_ENTER) or changemouse == true and Input.is_mouse_button_pressed(1) and !transition:
			locate = false
			locate2 = false
			select = 2
			tranum = 60
		if locatenum == 3 and Input.is_key_pressed(KEY_ENTER) or quitmouse == true and Input.is_mouse_button_pressed(1) and !transition:
			get_tree().quit()
	if select == 2 and locate2 == true:
		if locatenum2x == 1 and locatenum2y == 1 and Input.is_key_pressed(KEY_ENTER) or chassismouse == true and Input.is_mouse_button_pressed(1):
			Global.chassis = 1
		if locatenum2x == 1 and locatenum2y == 2 and Input.is_key_pressed(KEY_ENTER) or chassismouse2 == true and Input.is_mouse_button_pressed(1):
			Global.chassis = 2
		if locatenum2x == 2 and locatenum2y == 1 and Input.is_key_pressed(KEY_ENTER) or weaponmouse == true and Input.is_mouse_button_pressed(1):
			Global.weapon = 1
		if locatenum2x == 2 and locatenum2y == 2 and Input.is_key_pressed(KEY_ENTER) or weaponmouse2 == true and Input.is_mouse_button_pressed(1):
			Global.weapon = 2
		
		if Input.is_key_pressed(KEY_ESCAPE) and !transition:
			locate = false
			locate2 = false
			select = 1
			tranum = 60
