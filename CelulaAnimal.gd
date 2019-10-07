extends Node2D

var mitC = preload('res://Sprites/MitCerto.png')
var mitN = preload('res://Sprites/MitNormal.png')
var mitE = preload('res://Sprites/MitErrado.png')

var nucC = preload('res://Sprites/NucCerto.png')
var nucN = preload('res://Sprites/NucNormal.png')
var nucE = preload('res://Sprites/NucErrado.png')

var drag
var target
var origin

var mit = false
var nuc = false

var check = true

#posicionamento dos campos alvos
var mitx0 = 597
var mitx1 = 837
var mity0 = 318
var mity1 = 362

var nucx0 = 1070
var nucx1 = 1311
var nucy0 = 235
var nucy1 = 278

var mitPos = Vector2(717, 340)
var nucPos = Vector2(1190, 257)
#---------------------------------- 

var alternativas = ['Mitocôndria', 'Nucleo', 'Ribossomo', 'Parede Celular', 'Elétron', 'Reticulo', '1', '2', '3', '4', '5', '6']

func _ready():
	randomize()
	alternativas.shuffle()
	var j = 0
	for i in $Alternativas.get_children():
		i.id = alternativas[j]
		i.get_child(2).text = alternativas[j]
		j += 1

func _process(delta):
	if drag:
		target.set_position(get_viewport().get_mouse_position())
		target.set_z_index(2)

		for i in $Alternativas.get_children():
			if i != target:
				i.set_z_index(1)
		
	if target:
		check_position(target)

func check_position(target):
	if !drag:
		
		
		if target.position.x >= 597 and target.position.x <= 837 and target.position.y >= 318 and target.position.y <= 362:
			if !mit:
				if check:
					target.set_position(mitPos)
					check = false
					check_answer(target, 'mit')
			else:
				if target.id != "Mitocôndria":
					target.set_position(origin)
				
		elif target.position.x >= 1070 and target.position.x <= 1311 and target.position.y >= 235 and target.position.y <= 278:
			if !nuc:
				if check:
					target.set_position(nucPos)
					check = false
					check_answer(target, 'nuc')
			else:
				if target.id != "Nucleo":
					target.set_position(origin)
				
		elif target.position != origin:
			target.set_position(origin)

func check_answer(target, x):
	for i in $Alternativas.get_children():
		i.get_child(1).set_disabled(true)
		
	if x == 'mit':
		if target.id == 'Mitocôndria':
			target.input_pickable = false
			$Mitocondria/Mitocondria.set_texture(mitC)
			mit = true
			check = true
			for i in $Alternativas.get_children():
				if i != target:
					i.get_child(1).set_disabled(false)
		else:
			$Mitocondria/Mitocondria.set_texture(mitE)
			yield(get_tree().create_timer(1.5), 'timeout')
			
			target.set_position(origin)
			$Mitocondria/Mitocondria.set_texture(mitN)
			
			for i in $Alternativas.get_children():
				if nuc:
					if i.id != 'Nucleo':
						i.get_child(1).set_disabled(false)
				else:
					i.get_child(1).set_disabled(false)
			check = true
			
	if x == 'nuc':
		if target.id == 'Nucleo':
			target.input_pickable = false
			target.get_child(1).set_disabled(true)
			$Nucleo/Nucleo.set_texture(nucC)
			nuc = true
			check = true
			for i in $Alternativas.get_children():
				if i != target:
					i.get_child(1).set_disabled(false)
		else:
			$Nucleo/Nucleo.set_texture(nucE)
			yield(get_tree().create_timer(1.5), 'timeout')
			
			target.set_position(origin)
			$Nucleo/Nucleo.set_texture(nucN)
			
			for i in $Alternativas.get_children():
				if mit:
					if i.id != 'Mitocôndria':
						i.get_child(1).set_disabled(false)
				else:
					i.get_child(1).set_disabled(false)
			check = true














