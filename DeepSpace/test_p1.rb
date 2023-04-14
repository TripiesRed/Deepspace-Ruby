require_relative 'Dice'

module Deepspace
	class TestP1
	
		def main
			
			#Comprobaciones de Dice
			dice = Dice.new
			withHangars = 0
			withNoHangars = 0

			100.times do
			  if dice.initWithNHangars == 0
				 withNoHangars += 1
			  else
				 withHangars += 1
			  end
			end

			puts "Results Hangars: \n-WithHangars: " + withHangars.to_s + "\n-WithNoHangars: " + withNoHangars.to_s

			withShields = 0
			withNoShields = 0

			100.times do
			  if dice.initWithNShields == 0
				 withNoShields += 1
			  else
				 withShields += 1
			  end
			end

			puts "\nResults Shields: \n-withShields: " + withShields.to_s + "\n-withNoShields: " + withNoShields.to_s

			oneWeapon = 0
			twoWeapons = 0
			threeWeapons = 0

			100.times do
			  if dice.initWithNWeapons == 1
				 oneWeapon += 1
			  else 
				  if dice.initWithNWeapons == 2
					 twoWeapons += 1
				  else
					 threeWeapons += 1
				  end
			  end
			end

			puts "\nResults Weapons: \n-oneWeapon: " + oneWeapon.to_s + "\n-twoWeapons: " + twoWeapons.to_s + "\n-threeWeapons: " + threeWeapons.to_s

			spacestation = 0
			enemystarship = 0

			100.times do
			  if dice.firstShot == Deepspace::GameCharacter::SPACESTATION
				 spacestation += 1
			  else 
				  enemystarship += 1
			  end
			end

			puts "\nResults firstShot: \n-SpaceStation: " + spacestation.to_s + "\n-EnemyStarShip: " + enemystarship.to_s

			float_speed_value = 0.5
			evade = 0
			no_evade = 0

			100.times do
				if dice.spaceStationMoves(float_speed_value) == true
					evade += 1
				else
					no_evade += 1
				end
			end

			puts "\nResults Evades: \n-evade: " + evade.to_s + "\n-No evade: " + no_evade.to_s
		
		end #Fin método main
	
	end #Fin clase

end #Fin módulo

test = Deepspace::TestP1.new
test.main
