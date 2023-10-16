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

var grid = []
var selected_pic = []
var curhover = Vector2(0,0)
var found_same = []
var score = 0
var userplaying = false


enum GAME_STATE { WAITING, CHECKING, DESTROYING }
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
	
func _ready():
	for row in range(6):
		for col in range(5):
			grid.append(randi() % len(foodpics))
			changepic(row,col,grid[row * 5 + col])
	gamestate = GAME_STATE.CHECKING
	updatestates()
			
func updatepics():
	for row in range(6):
		for col in range(5):
			changepic(row,col,grid[row * 5 + col])

func checkgrid(row,col):
	if gamestate == GAME_STATE.CHECKING:
		var gridpos = row * 5 + col
		print("Checking row ",row," and col ",col, " food ",grid[gridpos])
		if found_same.size()==0:
			found_same.append({"pos":Vector2(col,row),"food":grid[gridpos]})
		else:
			print("Prev food: ",found_same[0].food," Cur food:",grid[gridpos])
			if found_same[0].food == grid[gridpos]:
				found_same.append({"pos":Vector2(col,row),"food":grid[gridpos]})
				print("Found same:",found_same)
			else:
				if found_same.size()>=3:
					print("Will destroy ",found_same)
					gamestate = GAME_STATE.DESTROYING
				if gamestate == GAME_STATE.CHECKING:
					found_same.clear()
					found_same.append({"pos":Vector2(col,row),"food":grid[gridpos]})
									
func updatestates():
	if gamestate == GAME_STATE.CHECKING:
		print("In checking rows")
		for row in range(6):
			for col in range(5):
				checkgrid(row,col)
			if found_same.size()>=3:
				print("Will destroy ",found_same)
				gamestate = GAME_STATE.DESTROYING
			if gamestate == GAME_STATE.CHECKING:
				found_same.clear()
	if gamestate == GAME_STATE.CHECKING:
		print("In checking cols")
		for col in range(5):
			for row in range(6):
				checkgrid(row,col)
			if found_same.size()>=3:
				print("Will destroy ",found_same)
				gamestate = GAME_STATE.DESTROYING
			if gamestate == GAME_STATE.CHECKING:
				found_same.clear()
	if gamestate == GAME_STATE.CHECKING:
		gamestate = GAME_STATE.WAITING
	if gamestate == GAME_STATE.DESTROYING:
		print("Destroying state")
		if found_same.size()>0:			
			var curdestroy = found_same.pop_front()
			print("Destorying ",curdestroy)
			while curdestroy.pos.y > 0:
				grid[curdestroy.pos.y * 5 + curdestroy.pos.x] = grid[(curdestroy.pos.y - 1) * 5 + curdestroy.pos.x]
				curdestroy.pos.y -= 1
			grid[curdestroy.pos.x] = randi() % len(foodpics)
			if userplaying:
				score += 10
			$HUD.scoreval = score
			print("Score: ",score)
		else:
			gamestate = GAME_STATE.CHECKING
	updatepics()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	updatestates()

func swap_pic(a,b):
	print("Will swap ",a," with ",b)
	var tmpgrid = grid[a.x * 5 + a.y]
	grid[a.x * 5 + a.y] = grid[b.x * 5 + b.y]
	grid[b.x * 5 + b.y] = tmpgrid
	changepic(a.x,a.y,grid[a.x * 5 + a.y])
	changepic(b.x,b.y,grid[b.x * 5 + b.y])
	change_selected(a)
	change_selected(b)
	selected_pic.clear()
	gamestate = GAME_STATE.CHECKING

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
		print("Last:",selected_pic)
		
func _on_food_mouse_entered(posy,posx):
	curhover.x = posx
	curhover.y = posy
