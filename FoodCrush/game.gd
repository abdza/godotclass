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
	'23_cheesecake_dish.png',
	'27_chocolate_dish.png',
	'29_cookies_dish.png',
	]

var grid = []
var cursel = Vector2(0,0)

func changepic(row,col,pic):
	var nodename = 'food_' + str(row) + '_' + str(col)
	var curnode = get_node(nodename)
	var imagename = "res://images/" + foodpics[pic]
	curnode.get_node('sprite').texture = load(imagename)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	for row in range(2):
		for col in range(5):
			grid.append(randi() % len(foodpics))
			changepic(row,col,grid[row * 5 + col])				

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_food_mouse_entered(posx,posy):
	print("Posx: ",posx, ", Posy:" ,posy)
