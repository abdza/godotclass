extends Node2D
var fail = false
var BaseHP = 100
var Baseblink = 0
var Baseblink2 = 0
var Baseblink3 = 0
#dead deretion  \/
var deathnum = 200
var death = deathnum
var death2 = 15
var death3 = 0
#player var
#blink deretion \/
var armornum = 100
#blink true  \/
var armor3 = 0
#blink fasle \/ 
var armor2 = 10
var armor = armornum
var dying = false
var lives = 3
var repair = 0
var repair2 = 0
var repair3 = 0
var repair4 = false
var score = 0
var num = 0
var shootingnum = 100
var shooting = false
var shooting2 = false
var ammo = false
var ammo2 = 0
var ammo3 = true
var ammo4 = 0
var ammo5 = 0
var ammo6 = 0
var lazerx = 0
var lazery = 0
var lazer1 = 0
var lazer2 = 0
var lazer3 = 0
var lazer4 = 0
var lazer5 = 0
var lazer6 = 0
var speedcap = 7
var speed = 0
var vspeed = 0
var rotatespeed = 0
var rotatespeedcap = 2
#enemy var
#enemy blink    \/ deretion
var Eblinknum = 8
#enemy blink true
var Eblink3 = 0
#enemy blink false
var Eblink2 = 2
var Eblink = Eblinknum
var enemyhitscore = true
var enemyhit = false
var enemyhit2 = false
var enemyhit3 = 0
var enemyhit4 = 0
var enemyhit5 = 4
var enemyhit8 = 0
var enemyhitx = 0
var enemyhity = 0
var enemyhp = 100
var hbH = 30
var hbV = 45
var enemy_speed = [2,2,2]
var timer
var damagenum = 0
var damagenum2 = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0,3):
		enemy_speed[i] = rand_range(1,3)

# Called every frame. 'delta' is the elapsed time since the previous frame.



func _process(delta):
	var enemies = [$enemytank1,$enemytank2,$enemytank3]
	timer = get_node("Timer")
	var beamdgfar = rand_range(5,15)
	var beamdgmid = rand_range(15,25)
	var beamdgclose = rand_range(25,40)
	var centerx = get_viewport().size.x / 2
	var centery = get_viewport().size.y / 2
	if $lazercannon.rotation_degrees > 0 and $lazercannon.rotation_degrees <= 90:
		lazer3 = 0.00493827160493827160493827160494 * $lazercannon.rotation_degrees
		lazer4 = 0.00493827160493827160493827160494 * (90 -$lazercannon.rotation_degrees)
		lazer1 = (0.44444444444444444444444444444444 + lazer4) * $lazercannon.rotation_degrees 
		lazer2 = (0.44444444444444444444444444444444 + lazer3) * (90 -$lazercannon.rotation_degrees)
		lazerx = lazer2 
		lazery = lazer1 
	if $lazercannon.rotation_degrees > 90 and $lazercannon.rotation_degrees <= 180:
		lazer5 = -0.00493827160493827160493827160494/1.20 * $lazercannon.rotation_degrees
		lazer3 = 0.00493827160493827160493827160494 * $lazercannon.rotation_degrees
		lazer4 = 0.00493827160493827160493827160494 * (100 -$lazercannon.rotation_degrees)
		if$lazercannon.rotation_degrees > 165:
			lazer5 = -0.00493827160493827160493827160494 * $lazercannon.rotation_degrees
			lazer6 = 4
		lazer1 = (0.44444444444444444444444444444444 + lazer4) * $lazercannon.rotation_degrees 
		lazer2 = (0.44444444444444444444444444444444 + lazer3 + lazer5) * (90 - $lazercannon.rotation_degrees) 
		lazerx = lazer2 - lazer6
		lazery = lazer1 - 8
		lazer6 = 0
	if $lazercannon.rotation_degrees < -90 and $lazercannon.rotation_degrees >= -180:
		lazer5 = -0.00493827160493827160493827160494/1.20 * $lazercannon.rotation_degrees
		lazer3 = 0.00493827160493827160493827160494 * $lazercannon.rotation_degrees
		lazer4 = 0.00493827160493827160493827160494 * (-90 -$lazercannon.rotation_degrees)
		if$lazercannon.rotation_degrees < -165:
			lazer5 = -0.00493827160493827160493827160494 * $lazercannon.rotation_degrees
			lazer6 = 4
		lazer1 = (0.44444444444444444444444444444444 - lazer4) * $lazercannon.rotation_degrees
		lazer2 = (0.44444444444444444444444444444444 - lazer3 - lazer5) * (-90 - $lazercannon.rotation_degrees)
		lazerx = -lazer2 - lazer6 
		lazery = lazer1 + 2
		lazer6 = 0
	if $lazercannon.rotation_degrees < -0 and $lazercannon.rotation_degrees >= -90:
		lazer3 = 0.00493827160493827160493827160494 * $lazercannon.rotation_degrees
		lazer4 = 0.00493827160493827160493827160494 * (-90 -$lazercannon.rotation_degrees)
		lazer1 = (0.44444444444444444444444444444444 - lazer4) * $lazercannon.rotation_degrees
		lazer2 = (0.44444444444444444444444444444444 - lazer3) * (-90 - $lazercannon.rotation_degrees)
		lazerx = -lazer2 
		lazery = lazer1 
	
	
	if $lazercannon.rotation_degrees >= 181:
		$lazercannon.rotation_degrees = -180
		$Hover.rotation_degrees -= 360
	if $lazercannon.rotation_degrees <= -181:
		$lazercannon.rotation_degrees = 180
		$Hover.rotation_degrees += 360
	$lazercannon.position.x = $Hover.position.x
	$lazercannon.position.y = $Hover.position.y
	$lazercannon2.position.x = $Hover.position.x
	$lazercannon2.position.y = $Hover.position.y
	$Base.rect_position.x = centerx
	$Base.rect_position.y = centery + centerx / 2 - 25
	
	if fail == false:
		$lazercannon.look_at(get_global_mouse_position())
		$lazercannon2.look_at(get_global_mouse_position())
		if $Hover.rotation_degrees > $lazercannon.rotation_degrees - 1:
			rotatespeed -= 0.015
		if $Hover.rotation_degrees < $lazercannon.rotation_degrees + 1:
			rotatespeed += 0.015
			# speed and vspeed and rotatespeed cap
		if rotatespeed > rotatespeedcap:
			rotatespeed = rotatespeedcap
		if rotatespeed < -rotatespeedcap:
			rotatespeed = -rotatespeedcap
		
		if speed > speedcap:
			speed = speedcap
		if vspeed > speedcap:
			vspeed = speedcap
			
		if speed < -speedcap:
			speed = -speedcap
		if vspeed < -speedcap:
			vspeed = -speedcap
		 #speed and vspeed and rotatespeed lower
		if rotatespeed < 0:
			rotatespeed += 0.0125
		if rotatespeed > 0:
			rotatespeed -= 0.0125
			
		if speed < 0:
			speed += 0.25
		if speed > 0:
			speed -= 0.25
			
		if vspeed < 0:
			vspeed += 0.25
		if vspeed > 0:
			vspeed -= 0.25
			
	#WASD controls speed and vspeed
		if Input.is_key_pressed(KEY_D):
			speed = speed - 0.5
			
		if Input.is_key_pressed(KEY_A):
			speed = speed + 0.5
			
		if Input.is_key_pressed(KEY_W):
			vspeed = vspeed - 0.5
		
		if Input.is_key_pressed(KEY_S):
			vspeed = vspeed + 0.5
	#player move
		$Hover.position.y += vspeed
		$Hover.position.x -= speed
		$Hover.rotate(rotatespeed)
		$lazercannon.position.x = $Hover.position.x
		$lazercannon.position.y = $Hover.position.y
		$lazercannon2.position.x = $Hover.position.x
		$lazercannon2.position.y = $Hover.position.y
	
	#player wall
		if $Hover.position.y <= 0 :
			$Hover.position.y = 0
		if $Hover.position.y + 30 >= get_viewport().size.y:
			$Hover.position.y = get_viewport().size.y - 30
		if $Hover.position.x <= 0 :
			$Hover.position.x = 0
		if $Hover.position.x + 30 >= get_viewport().size.x:
			$Hover.position.x = get_viewport().size.x - 30
			
	#this controls how long the laser last
		
		if shooting == false and ammo == false and ammo4 <= 0:
			shootingnum += 2
		if shooting == true and ammo == false:
			shootingnum -= 2
			ammo4 = 10
		if shootingnum == 0 and ammo == false:
			ammo = true
			ammo2 = 100
			ammo3 = false
			ammo5 = 10
		if ammo5 > 0 and ammo == true:
			$lazercannon2.visible = true
			ammo5 -= 1
		if ammo5 <= 0 and ammo == true:
			$lazercannon2.visible = false
			ammo6 += 1
		if ammo6 >= 10 and ammo == true:
			ammo5 = 10
			ammo6 = 0
		if ammo == true:
			ammo2 -= 1
			$ammo.rect_scale.x = rand_range(3,4)
			$ammo.rect_scale.y = rand_range(3,4)
		if ammo2 <= 0:
			ammo = false
			ammo5 = 0
			ammo6 = 0
			$ammo.rect_scale.x = 3
			$ammo.rect_scale.y = 3
			$lazercannon2.visible = false
		if shootingnum > 100:
			shootingnum = 100
			if shooting2 == false:
				ammo3 = true
		if ammo4 > 0:
			ammo4 -= 1
			
			
			
			
			
			
			
			
			
	# when shootingnum gets under 0 it will reset with this
		if shooting == false:
			$longbeam.visible = false
			$beam.position.x = 2000
			$beam2.position.x = 2000
			$beam3.position.x = 2000
			$beam4.position.x = 2000
			$beam5.position.x = 2000
			$beam6.position.x = 2000
			$beam7.position.x = 2000
			$beam8.position.x = 2000
			$beam9.position.x = 2000
			$beam10.position.x = 2000
			$beam11.position.x = 2000
		shooting = false
		shooting2 = false
	#tracking
		$longbeam.position.x = $lazercannon.position.x 
		$longbeam.position.y = $lazercannon.position.y 
		$longbeam.rotation_degrees = $lazercannon.rotation_degrees
	#the shoot controls
		if Input.is_mouse_button_pressed(1) and dying == false :
			shooting2 = true
		#failsafe
			if shootingnum > 0 and ammo3 == true :
				shooting = true
				$longbeam.visible = true
				$beam.position.x = $lazercannon.position.x + lazerx * 2
				$beam.position.y = $lazercannon.position.y + lazery * 2
				$beam2.position.x = $lazercannon.position.x + lazerx * 3
				$beam2.position.y = $lazercannon.position.y + lazery * 3
				$beam3.position.x = $lazercannon.position.x + lazerx * 4
				$beam3.position.y = $lazercannon.position.y + lazery * 4
				$beam4.position.x = $lazercannon.position.x + lazerx * 5
				$beam4.position.y = $lazercannon.position.y + lazery * 5
				$beam5.position.x = $lazercannon.position.x + lazerx * 6
				$beam5.position.y = $lazercannon.position.y + lazery * 6
				$beam6.position.x = $lazercannon.position.x + lazerx * 7
				$beam6.position.y = $lazercannon.position.y + lazery * 7
				$beam7.position.x = $lazercannon.position.x + lazerx * 8
				$beam7.position.y = $lazercannon.position.y + lazery * 8
				$beam8.position.x = $lazercannon.position.x + lazerx * 9
				$beam8.position.y = $lazercannon.position.y + lazery * 9
				$beam9.position.x = $lazercannon.position.x + lazerx * 10
				$beam9.position.y = $lazercannon.position.y + lazery * 10
				$beam10.position.x = $lazercannon.position.x + lazerx * 11
				$beam10.position.y = $lazercannon.position.y + lazery * 11
				$beam11.position.x = $lazercannon.position.x + lazerx * 12
				$beam11.position.y = $lazercannon.position.y + lazery * 12
			
		
		
		
		
		
		
		
		
		
	#dying
		if dying == true:
			speedcap = 3
			$lazercannon.visible = false
			if armor2 > 0:
				$Hover.visible = false
				$lazercannon2.visible = false
				armor2 -= 1
				armor -= 1
			if armor2 <= 0:
				$Hover.visible = true
				$lazercannon2.visible = true
				armor3 += 1
				armor -= 1
			if armor3 >= 10:
				armor2 = 10
				armor3 = 0
			if armor <= 0:
				dying = false
				$Hover.visible = true
				$lazercannon.visible = true
				$lazercannon2.visible = false
				armor = armornum
				armor2 = 10
				armor3 = 0
				speedcap = 7
		if lives <= 0:
			$Hover.visible = false
			$lazercannon.visible = false
			$lazercannon2.visible = false
			repair = 100
			repair2 = 10
			repair4 = true
			$Hover.position.x = centerx
			$Hover.position.y = centery + 300
			lives = 3
		if repair > 0:
			repair -= 1
			speedcap = 0
			if repair2 > 0:
				$lives.visible = false
				repair2 -= 1
			if repair2 <= 0:
				$lives.visible = true
				repair3 += 1
			if repair3 >= 10:
				repair2 = 10
				repair3 = 0
		if repair <= 0 and repair4 == true:
			$lives.visible = true
			$Hover.position.x = centerx
			$Hover.position.y = centery + 300
			$Hover.visible = true
			$lazercannon.visible = true
			speedcap = 7
			repair2 = 0
			repair3 = 0
			repair4 = false
		if Baseblink > 0:
			Baseblink -= 1
			if Baseblink2 > 0:
				$Base.visible = false
				Baseblink2 -= 0
			if Baseblink2 <= 0:
				Baseblink3 += 1
				$Base.visible = true
		if Baseblink <= 0:
			$Base.visible = true
			Baseblink2 = 0
			Baseblink3 = 0
			
			
			
			
			
			
			
			
			
			
	#enemy hit box
	#note all beam parts are acting as the longbeam`s hit box
		var pos = 0
		for enemy in enemies:
			enemy.position.y += enemy_speed[pos]
			var restart_enemy = false
			if $beam.position.x > enemy.position.x - hbH and $beam.position.x < enemy.position.x + hbH \
			and	$beam.position.y > enemy.position.y - hbV and $beam.position.y < enemy.position.y + hbV:
				if enemyhit == false:
					enemy.visible = false
					enemyhit = true
					enemyhit2 = true
					enemyhit3 = enemyhp
					enemyhp -= beamdgclose
					enemyhit3 -= enemyhp
					damagenum2 = enemyhit3
					enemyhit3 = 0
					damagenum += damagenum2
					$ETdamage.rect_position.x = enemy.position.x
					$ETdamage.rect_position.y = enemy.position.y
			if $beam2.position.x > enemy.position.x - hbH and $beam2.position.x < enemy.position.x + hbH \
			and	$beam2.position.y > enemy.position.y - hbV and $beam2.position.y < enemy.position.y + hbV:
				if enemyhit == false:
					enemy.visible = false
					enemyhit = true
					enemyhit2 = true
					enemyhit3 = enemyhp
					enemyhp -= beamdgclose
					enemyhit3 -= enemyhp
					damagenum2 = enemyhit3
					enemyhit3 = 0
					damagenum += damagenum2
					$ETdamage.rect_position.x = enemy.position.x
					$ETdamage.rect_position.y = enemy.position.y
			if $beam3.position.x > enemy.position.x - hbH and $beam3.position.x < enemy.position.x + hbH \
			and	$beam3.position.y > enemy.position.y - hbV and $beam3.position.y < enemy.position.y + hbV:
				if enemyhit == false:
					enemy.visible = false
					enemyhit = true
					enemyhit2 = true
					enemyhit3 = enemyhp
					enemyhp -= beamdgclose
					enemyhit3 -= enemyhp
					damagenum2 = enemyhit3
					enemyhit3 = 0
					damagenum += damagenum2
					$ETdamage.rect_position.x = enemy.position.x
					$ETdamage.rect_position.y = enemy.position.y
			if $beam4.position.x > enemy.position.x - hbH and $beam4.position.x < enemy.position.x + hbH \
			and	$beam4.position.y > enemy.position.y - hbV and $beam4.position.y < enemy.position.y + hbV:
				if enemyhit == false:
					enemy.visible = false
					enemyhit = true
					enemyhit2 = true
					enemyhit3 = enemyhp
					enemyhp -= beamdgmid
					enemyhit3 -= enemyhp
					damagenum2 = enemyhit3
					enemyhit3 = 0
					damagenum += damagenum2
					$ETdamage.rect_position.x = enemy.position.x
					$ETdamage.rect_position.y = enemy.position.y
			if $beam5.position.x > enemy.position.x - hbH and $beam5.position.x < enemy.position.x + hbH \
			and	$beam5.position.y > enemy.position.y - hbV and $beam5.position.y < enemy.position.y + hbV:
				if enemyhit == false:
					enemy.visible = false
					enemyhit = true
					enemyhit2 = true
					enemyhit3 = enemyhp
					enemyhp -= beamdgmid
					enemyhit3 -= enemyhp
					damagenum2 = enemyhit3
					enemyhit3 = 0
					damagenum += damagenum2
					$ETdamage.rect_position.x = enemy.position.x
					$ETdamage.rect_position.y = enemy.position.y
			if $beam6.position.x > enemy.position.x - hbH and $beam6.position.x < enemy.position.x + hbH \
			and	$beam6.position.y > enemy.position.y - hbV and $beam6.position.y < enemy.position.y + hbV:
				if enemyhit == false:
					enemy.visible = false
					enemyhit = true
					enemyhit2 = true
					enemyhit3 = enemyhp
					enemyhp -= beamdgmid
					enemyhit3 -= enemyhp
					damagenum2 = enemyhit3
					enemyhit3 = 0
					damagenum += damagenum2
					$ETdamage.rect_position.x = enemy.position.x
					$ETdamage.rect_position.y = enemy.position.y
			if $beam7.position.x > enemy.position.x - hbH and $beam7.position.x < enemy.position.x + hbH \
			and	$beam7.position.y > enemy.position.y - hbV and $beam7.position.y < enemy.position.y + hbV:
				if enemyhit == false:
					enemy.visible = false
					enemyhit = true
					enemyhit2 = true
					enemyhit3 = enemyhp
					enemyhp -= beamdgmid
					enemyhit3 -= enemyhp
					damagenum2 = enemyhit3
					enemyhit3 = 0
					damagenum += damagenum2
					$ETdamage.rect_position.x = enemy.position.x
					$ETdamage.rect_position.y = enemy.position.y
			if $beam8.position.x > enemy.position.x - hbH and $beam8.position.x < enemy.position.x + hbH \
			and	$beam8.position.y > enemy.position.y - hbV and $beam8.position.y < enemy.position.y + hbV:
				if enemyhit == false:
					enemy.visible = false
					enemyhit = true
					enemyhit2 = true
					enemyhit3 = enemyhp
					enemyhp -= beamdgfar
					enemyhit3 -= enemyhp
					damagenum2 = enemyhit3
					enemyhit3 = 0
					damagenum += damagenum2
					$ETdamage.rect_position.x = enemy.position.x
					$ETdamage.rect_position.y = enemy.position.y
			if $beam9.position.x > enemy.position.x - hbH and $beam9.position.x < enemy.position.x + hbH \
			and	$beam9.position.y > enemy.position.y - hbV and $beam9.position.y < enemy.position.y + hbV:
				if enemyhit == false:
					enemy.visible = false
					enemyhit = true
					enemyhit2 = true
					enemyhit3 = enemyhp
					enemyhp -= beamdgfar
					enemyhit3 -= enemyhp
					damagenum2 = enemyhit3
					enemyhit3 = 0
					damagenum += damagenum2
					$ETdamage.rect_position.x = enemy.position.x
					$ETdamage.rect_position.y = enemy.position.y
			if $beam10.position.x > enemy.position.x - hbH and $beam10.position.x < enemy.position.x + hbH \
			and	$beam10.position.y > enemy.position.y - hbV and $beam10.position.y < enemy.position.y + hbV:
				if enemyhit == false:
					enemy.visible = false
					enemyhit = true
					enemyhit2 = true
					enemyhit3 = enemyhp
					enemyhp -= beamdgfar
					enemyhit3 -= enemyhp
					damagenum2 = enemyhit3
					enemyhit3 = 0
					damagenum += damagenum2
					$ETdamage.rect_position.x = enemy.position.x
					$ETdamage.rect_position.y = enemy.position.y
			if $beam11.position.x > enemy.position.x - hbH and $beam11.position.x < enemy.position.x + hbH \
			and	$beam11.position.y > enemy.position.y - hbV and $beam11.position.y < enemy.position.y + hbV:
				if enemyhit == false:
					enemy.visible = false
					enemyhit = true
					enemyhit2 = true
					enemyhit3 = enemyhp
					enemyhp -= beamdgfar
					enemyhit3 -= enemyhp
					damagenum2 = enemyhit3
					enemyhit3 = 0
					damagenum += damagenum2
					$ETdamage.rect_position.x = enemy.position.x
					$ETdamage.rect_position.y = enemy.position.y
						
			if $Hover.position.x > enemy.position.x - 50 and $Hover.position.x < enemy.position.x + 50 \
			and	$Hover.position.y > enemy.position.y - 50 and $Hover.position.y < enemy.position.y + 50:
				if dying == false and repair4 == false:
					score -= 150
					enemy.visible = false
					restart_enemy = true
					lives = lives - 1
					if lives > 0:
						dying = true
					
			if enemyhit == true:
				if enemyhitscore == false:
					score += 5
					enemyhitscore = true
				if Eblink2 > 0:
					enemy.visible = false
					Eblink2 -= 1
					Eblink -= 1
				if Eblink2 <= 0:
					enemy.visible = true
					Eblink3 += 1
					Eblink -= 1
				if Eblink3 >= 2:
					Eblink2 == 2
					Eblink3 == 0
				if Eblink <= 0:
					enemyhit = false
					enemy.visible = true
					Eblink = Eblinknum
					Eblink2 = 2
					Eblink3 = 0
					enemyhitscore = false
						
			if enemyhit2 == true:
				enemyhit8 = 100
				enemyhit4 = 0
				enemyhit5 = 6
				enemyhitx = 0
				enemyhity = 0
				enemyhitx += rand_range(-0.25,0.25)
				enemyhity += rand_range(-0.1,-0.3)
				$ETdamage.visible = true
				$ETdamage.rect_scale.x = 0
				$ETdamage.rect_scale.y = 0
				enemyhit2 = false
			if enemyhit5 > 0:
				$ETdamage.rect_scale.x += 0.5
				$ETdamage.rect_scale.y += 0.5
				$ETdamage.rect_position.x += enemyhitx
				$ETdamage.rect_position.y += enemyhity
				enemyhit5 -= 1
			if enemyhit5 == 0:
				enemyhit5 -= 1
				enemyhit4 = 100
			if enemyhit4 > 0:
				$ETdamage.rect_position.x += enemyhitx
				$ETdamage.rect_position.y += enemyhity
				$ETdamage.rect_scale.x -= 0.025
				$ETdamage.rect_scale.y -= 0.025
				if $ETdamage.rect_scale.x < 0:
					$ETdamage.rect_scale.x = 0
				if $ETdamage.rect_scale.y < 0:
					$ETdamage.rect_scale.y = 0
				enemyhit4 -= 1
				enemyhit8 -= 1
			if enemyhit8 <= 0:
				$ETdamage.visible = false
				enemyhitx = 0
				enemyhity = 0
				damagenum = 0
			if enemyhp <= 0:
				restart_enemy = true
				enemyhp = 100
			#if enemy off screen, reset
			if enemy.position.y > get_viewport().size.y:
				restart_enemy = true
				score -= 100
				BaseHP -= 10
				Baseblink = 20
				Baseblink2 = 5
				Baseblink3 = 0
			if restart_enemy:
				enemy.visible = true
				enemy.position.y = -10
				enemy.position.x = rand_range(1,get_viewport().size.x)
				enemy_speed[pos] = rand_range(2,3)
				score += 50
				pos += 1
	if damagenum >= 10:
		$ETdamage.rect_size.x = 18
	if damagenum >= 100:
		$ETdamage.rect_size.x = 25
		#score
	$ammo.rect_position.y = get_viewport().size.y - 50
	$ammo.rect_position.x = get_viewport().size.x - 110
	$scorenum.text = "score " + str(score)
	$lives.text = "lives " + str(lives)
	$Base.text = "BaseHP:" + str(BaseHP)
	if repair4 == true:
		$lives.text = "lives 0" 
	$ETdamage.text = str(damagenum)
	$ammo.text = str(shootingnum) + "%"
	if BaseHP <= 0:
		fail = true
	if fail == true:
		dying = false
		$longbeam.visible = false
		$lazercannon2.visible = false
		speedcap = 0
		death -= 1
		if death2 > 0:
			$Hover.visible = false
			$lazercannon.visible = false
			$enemytank1.visible = false
			$enemytank2.visible = false
			$enemytank3.visible = false
			$scorenum.visible = false
			$lives.visible = false
			$ETdamage.visible = false
			death2 -= 1
		if death2 <= 0:
			$Hover.visible = true
			$lazercannon.visible = true
			$enemytank1.visible = true
			$enemytank2.visible = true
			$enemytank3.visible = true
			$scorenum.visible = true
			$lives.visible = true
			$ETdamage.visible = true
			death3 += 1
		if  death3 >= 15:
			death2 = 15
			death3 = 0
		if death <= 0:
			$Hover.visible = true
			$lazercannon.visible = true
			$enemytank1.visible = true
			$enemytank2.visible = true
			$enemytank3.visible = true
			$scorenum.visible = true
			$lives.visible = true
			$ETdamage.visible = false
			score = 0
			lives = 3
			fail = false
			dying = false
			BaseHP = 100
			death = deathnum
			death2 = 15
			death3 = 0
			armor = armornum
			armor2 = 10
			armor3 = 0
			speedcap = 7
			get_tree().change_scene("res://secne/gameover.tscn")
