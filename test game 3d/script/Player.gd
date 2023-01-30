extends Sprite
var chassis = 0
var weapon = 0

func _ready():
	if Global.chassis == 1:
		chassis = 1
	if Global.chassis == 1:
		chassis = 2
	if Global.weapon == 1:
		weapon = 1
	if Global.weapon == 1:
		weapon = 2
		$longbeam.visible = false
	
	if chassis == 1:
		$oger.visible = false
	if chassis == 2:
		$Hover.visible = false
	if weapon == 1:
		$cannon.visible = false
	if weapon == 2:
		$longbeam.visible = false







func _process(delta):
	
	pass
