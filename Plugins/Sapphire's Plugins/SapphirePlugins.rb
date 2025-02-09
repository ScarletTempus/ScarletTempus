def pbCheckNatureAction(nature)
	if [:ADAMANT, :CALM, :JOLLY, :LAX, :LONELY, :MODEST, :NAIVE, :QUIET, :RELAXED, :SASSY].include?(nature)
		#Join
		return 1
	elsif [:BASHFUL, :CAREFUL, :DOCILE, :GENTLE, :IMPISH, :TIMID].include?(nature)
		#Run
		return 2
	elsif [:BOLD, :BRAVE, :HARDY, :HASTY, :NAUGHTY, :RASH].include?(nature)
		#Attack
		return 3
	else
		#Randomize for Mild, Quirky, and Serious
		randomAction = rand(1..3)
		return randomAction
	end
end

def pbSetIVs
	# Randomize each IV
	tempPerfect = rand(0..5)
	healthIV = rand(25..31)
	attackIV = rand(25..31)
	defenseIV = rand(25..31)
	spAttackIV = rand(25..31)
	spDefenseIV = rand(25..31)
	speedIV = rand(25..31)
	
	#Set the random perfect IV
	case tempPerfect 
	when 0
		healthIV = 31
	when 1
		attackIV = 31
	when 2
		defenseIV = 31
	when 3
		spAttackIV = 31
	when 4
		spDefenseIV = 31
	when 5
		speedIV = 31
	end
	# Return the IVs to set them in the event
	return [healthIV, attackIV, defenseIV, spAttackIV, spDefenseIV, speedIV]
end

def pbSetEggMove(move1, move2, move3)
	tempMove = rand(0..2)
	case tempMove
	when 0
		pbGet(30).learn_move(move1)
	when 1
		pbGet(30).learn_move(move2)
	when 2
		pbGet(30).learn_move(move3)
	end
end

def pbSetStatus

	# 0 = PARALYSIS
	# 1 = BURN
	# 2 = POISON
	randStatus = rand(0..2)
  
	# Check if electric, then don't allow Paralysis
	if pbGet(30).types.include?:ELECTRIC
		randStatus = rand(1..2)
	end
	# Check if fire, then don't allow Burn
	if pbGet(30).types.include?:FIRE
    tempStatus = rand(0..1)
		if tempStatus == 0
			randStatus = 0
		else
			randStatus = 2
		end
	end
	# If poison, then don't allow Poison
	if pbGet(30).types.include?:POISON
		randStatus = rand(0..1)
	end
  
	# Set the status
	case randStatus
	when 0
		pbGet(30).status = :PARALYSIS	
	when 1
		pbGet(30).status = :BURN
	when 2
		pbGet(30).status = :POISON
	end
end

def pbCheckSpecies(species, form = 0)
	pbSet(31, 0)
	$player.party.each do |pkmn|
		next if pkmn.species != species
		next if pkmn.form != form
		pbSet(31, 1) if pkmn.egg?
		return true
	end
	GameData::Species.get(species).get_family_species.each do |evo|
		next if evo != species
		return true
	end
   return false
end

def checkForQuest(quest)
	quests = getCompletedQuests
		if quests.to_s.include? quest.to_s
			return true
		end
	return false
end

def pbSetHerName()
	return "Yas♀"
end