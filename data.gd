extends Node
var HaveWeaponFlamethrower = false
var HaveWeaponPush = false
var HaveWeaponNuke = false
var HaveWeaponBox = false
var WeaponUnlock = 0
var ZenMode = false
var TimeTrialMode = false
var level = 0
var BlocksBroken = 100

var time_trials_objects_destroyed = 0

# this script is a "global" script, meaning it is always loaded, even between scene changes
# this can be found in the project > project settings > globals tab

# this is better than using just numbers to select weapon
# enum is a common thing in most programming languages also,
enum Weapon {
	FLAMETHROWER,
	CLICK,
	BOX,
	PUSH,
	NUKE
}

var current_weapon = Weapon.CLICK

func Unlock():

		if HaveWeaponFlamethrower == false:
			HaveWeaponFlamethrower = true
		elif HaveWeaponPush == false:
			HaveWeaponPush = true
		elif HaveWeaponNuke == false:
			HaveWeaponNuke = true
		else:
			print("No Weapons left to aquire")




func weapon_name(weapon):
	match weapon:
		Weapon.FLAMETHROWER:
			if HaveWeaponFlamethrower == true:
				return "Flamethrower"
			else :
				return "Weapon not aquired yet"
		Weapon.CLICK:
			return "Cursor"
		Weapon.BOX:
			if HaveWeaponBox == true:
				return "Box Cannon"
			else :
				return "You do not have access to this weapon"
		Weapon.PUSH:
			if HaveWeaponPush == true:
				return "Push"
			else :
				return "Weapon not aquired yet"
		Weapon.NUKE:
			if HaveWeaponNuke == true:
				return "Orbital Stike Cannon"
			else :
				return "Weapon not aquired yet"
	return "UNKNOWN WEAPON"

# screen shake
const SHAKING_DIMINISH = 0.9  # decreases additional shaking if it is already shaking a lot
const SHAKING_GO_AWAY = 0.3  # decreases existing shaking (if it is already shaking)
var shaking_amt: int = 0


func shake_screen(amt: int) -> void:
	shaking_amt = amt*pow(SHAKING_DIMINISH, shaking_amt)


func _process(delta: float) -> void:
	shaking_amt *= 1-delta*SHAKING_GO_AWAY
	if BlocksBroken <= 0 :
		if level == 1 :
			BlocksBroken = 100
			get_tree().change_scene_to_file("res://level_2.tscn")
		if level == 2 :
			BlocksBroken = 100
			get_tree().change_scene_to_file("res://level_3.tscn")
		if level == 3 :
			BlocksBroken = 100
			get_tree().change_scene_to_file("res://main.tscn")
			
	
	if Input.is_action_just_pressed("reset"):
		Data.levelfail()

		

func blockbreak():
	BlocksBroken -= 1

func levelfail():
	if level == 1 :
		get_tree().call_group("Scenes", "queue free")
		get_tree().change_scene_to_file("res://level_1.tscn")
	if level == 2 :
		get_tree().call_group("Scenes", "queue free")
		get_tree().change_scene_to_file("res://level_2.tscn")
	if level == 3 :
		get_tree().call_group("Scenes", "queue free")
		get_tree().change_scene_to_file("res://level_3.tscn")
	
