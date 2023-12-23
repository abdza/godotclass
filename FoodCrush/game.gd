extends Node2D

var foodpics = [
	'06_apple_pie_dish.png',
	'08_bread_dish.png',
	'10_baguette_dish.png',
	'12_bun_dish.png',
	'14_bacon_dish.png',
	'16_burger_dish.png',
	'19_burrito_dish.png',
	'21_bagel_dish.png',
	'23_cheesecake_dish.png'
	]

var target_score = [50,100,200,600,750,1000]
var turnlimit = [300,5,8,12,15,18]
var grid = []
var selected_pic = []
var curhover = Vector2(0,0)
var found_same = []
var score = 0
var userplaying = false
var turnstaken = 0
var animating_blocks = []
var toswap = []

enum GAME_STATE { WAITING, CHECKING, DESTROYING, ANIMATING }
var gamestate = GAME_STATE.WAITING

func changepic(row,col,pic):
	var nodename = 'food_' + str(row) + '_' + str(col)
	var curnode = get_node(nodename)
	var imagename = "res://images/" + foodpics[pic]
	curnode.get_node('sprite').texture = load(imagename)
	
func change_selected(location):
	var nodename = 'food_' + str(location.x) + '_' + str(location.y)
	var curnode = get_node(nodename)
	curnode.cur_selected = not curnode.cur_selected
	
func change_animation(location,animation):
	var nodename = 'food_' + str(location.x) + '_' + str(location.y)
	var curnode = get_node(nodename)
	print("Changing animation for ",curnode," to ",animation)
	curnode.current_animation = animation
	
func check_animation(location):
	var nodename = 'food_' + str(location.x) + '_' + str(location.y)
	var curnode = get_node(nodename)
	if curnode.current_animation == "":
		return false
	else:
		return true
		
func _ready():
	for row in range(6):
		for col in range(5):
			grid.append(randi() % len(foodpics))
			changepic(row,col,grid[row * 5 + col])
	gamestate = GAME_STATE.CHECKING
	turnstaken = 0
	$HUD.targetval = target_score[Global.playerlevel - 1]
	updatestates()
			
func updatepics():
	for row in range(6):
		for col in range(5):
			changepic(row,col,grid[row * 5 + col])

func checkgrid(row,col):
	if gamestate == GAME_STATE.CHECKING:
		var gridpos = row * 5 + col
		# print("Checking row ",row," and col ",col, " food ",grid[gridpos])
		if found_same.size()==0:
			found_same.append({"pos":Vector2(col,row),"food":grid[gridpos]})
		else:
			# print("Prev food: ",found_same[0].food," Cur food:",grid[gridpos])
			if found_same[0].food == grid[gridpos]:
				found_same.append({"pos":Vector2(col,row),"food":grid[gridpos]})
				# print("Found same:",found_same)
			else:
				if found_same.size()>=3:
					# print("Will destroy ",found_same)
					gamestate = GAME_STATE.DESTROYING
				if gamestate == GAME_STATE.CHECKING:
					found_same.clear()
					found_same.append({"pos":Vector2(col,row),"food":grid[gridpos]})
									
func updatestates():
	if gamestate == GAME_STATE.ANIMATING:
		for block in animating_blocks:
			if not check_animation(block):
				animating_blocks.erase(block)
		if animating_blocks.size()==0:
			var a = toswap[0]
			var b = toswap[1]
			var tmpgrid = grid[a.x * 5 + a.y]
			grid[a.x * 5 + a.y] = grid[b.x * 5 + b.y]
			grid[b.x * 5 + b.y] = tmpgrid
			changepic(a.x,a.y,grid[a.x * 5 + a.y])
			changepic(b.x,b.y,grid[b.x * 5 + b.y])
			updatepics()
			gamestate = GAME_STATE.CHECKING
	if gamestate == GAME_STATE.CHECKING:
		# print("Checking score")
		if score >= target_score[Global.playerlevel - 1]:
			get_tree().change_scene_to_file("res://won_level.tscn")
		# print("In checking rows")
		for row in range(6):
			for col in range(5):
				checkgrid(row,col)
			if found_same.size()>=3:
				# print("Will destroy ",found_same)
				gamestate = GAME_STATE.DESTROYING
			if gamestate == GAME_STATE.CHECKING:
				found_same.clear()
	if gamestate == GAME_STATE.CHECKING:		
		# print("In checking cols")
		for col in range(5):
			for row in range(6):
				checkgrid(row,col)
			if found_same.size()>=3:
				# print("Will destroy ",found_same)
				gamestate = GAME_STATE.DESTROYING
			if gamestate == GAME_STATE.CHECKING:
				found_same.clear()
	if gamestate == GAME_STATE.CHECKING:
		gamestate = GAME_STATE.WAITING
		turnstaken += 1
		$HUD.turnval = turnstaken - 1
		$HUD.turntargetval = turnlimit[Global.playerlevel - 1]
		if turnstaken > turnlimit[Global.playerlevel - 1]:
			get_tree().change_scene_to_file("res://lose_level.tscn")
		# print("Turns:",turnstaken)
	if gamestate == GAME_STATE.DESTROYING:
		# print("Destroying state")
		if found_same.size()>0:			
			var curdestroy = found_same.pop_front()
			# print("Destorying ",curdestroy)
			while curdestroy.pos.y > 0:
				grid[curdestroy.pos.y * 5 + curdestroy.pos.x] = grid[(curdestroy.pos.y - 1) * 5 + curdestroy.pos.x]
				curdestroy.pos.y -= 1
			grid[curdestroy.pos.x] = randi() % len(foodpics)
			if userplaying:
				score += 10
			$HUD.scoreval = score
			$HUD.targetval = target_score[Global.playerlevel - 1]
			# print("Score: ",score)
		else:
			gamestate = GAME_STATE.CHECKING
	updatepics()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	updatestates()

func swap_pic(a,b):
	change_selected(a)
	change_selected(b)
	selected_pic.clear()
	print("Will swap ",a," with ",b)
	print("a.x:",a.x," a.y:",a.y," b.x:",b.x," b.y:",b.y)
	animating_blocks.append(a)
	animating_blocks.append(b)
	toswap = [a,b]	
	if a.x==b.x:
		print("On same row")
		if a.y<b.y:
			print("a left of b")
			change_animation(a,"go_right")
			change_animation(b,"go_left")
		else:
			print("b left of a")
			change_animation(a,"go_left")
			change_animation(b,"go_right")
	elif a.y==b.y:
		print("On same column")
		if a.x<b.x:
			print("a above of b")
			change_animation(a,"go_down")
			change_animation(b,"go_up")
		else:
			print("b left of a")
			change_animation(a,"go_up")
			change_animation(b,"go_down")
	gamestate = GAME_STATE.ANIMATING

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and gamestate == GAME_STATE.WAITING:
		print("First:",selected_pic)
		userplaying = true
		change_selected(curhover)
		if selected_pic.size()==0:
			selected_pic.append(curhover)			
		elif selected_pic.size()==1:
			if selected_pic[0]==curhover:
				selected_pic.clear()
			else:
				var distance_one = abs(selected_pic[0].x - curhover.x)<2 and abs(selected_pic[0].y - curhover.y)<2
				var same_row_col = selected_pic[0].x==curhover.x or selected_pic[0].y==curhover.y
				if distance_one and same_row_col:
					selected_pic.append(curhover)
					swap_pic(curhover,selected_pic[0])
				else:
					change_selected(selected_pic[0])
					selected_pic.clear()
					selected_pic.append(curhover)
		else:
			for sp in selected_pic:
				change_selected(sp)
			selected_pic.clear()
		# print("Last:",selected_pic)
		
func _on_food_mouse_entered(posy,posx):
	curhover.x = posx
	curhover.y = posy
