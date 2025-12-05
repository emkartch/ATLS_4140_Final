extends Area2D
#Cell

var index = -1
var occupied = false #to check whether a piece is occupying the cell


@onready var sprite2D: Sprite2D = $Sprite2D
@onready var collishape: CollisionShape2D = $CollisionShape2D

func init_cell(
	_index: int,
	piece_size: Vector2
):
	index = _index
	
	#set cell for the cell based on piece size
	sprite2D.texture.set("width", piece_size.x)
	sprite2D.scale = Vector2(1, piece_size.y)
	
	#update shape of collider
	collishape.shape.set("size", piece_size)
	
func is_free():
	return not occupied 

func occupy():
	occupied = true
	
func unoccupy():
	occupied = false 	  	
