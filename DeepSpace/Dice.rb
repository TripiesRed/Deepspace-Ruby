require_relative 'GameCharacter'
module Deepspace
	class Dice
		
		@@NADA=0
		@@UNO=1
		
		def initialize 
			
			@NHANGARSPROB=0.25
			@NSHIELDSPROB=0.25
			@NWEAPONSPROB=0.33
			@FIRSTSHOTPROB=0.5
			@generator=Random.new
		
		end
		
		def initWithNHangars
			
			if @generator.rand < @NHANGARSPROB
				return @@NADA
			
			else 
				return @@UNO
			end
		
		end
		
		def initWithNWeapons
			
			random_value=@generator.rand
			result=0
		
			if random_value < @NWEAPONSPROB
				result=1
			
			else
				if random_value < 2*@NWEAPONSPROB
					result=2
				else
					result=3
				end
			end
			
			return result
			
		end
		
		def initWithNShields
			
			if @generator.rand < @NSHIELDSPROB
				return @@NADA
			
			else 
				return @@UNO
			end
		
		end
		
		def whoStarts (nPlayers)
		
			return @generator.rand(nPlayers)
		
		end
		
		def firstShot
		
			if @generator.rand < @FIRSTSHOTPROB
				return GameCharacter::SPACESTATION
				
			else
				return GameCharacter::ENEMYSTARSHIP
			end
			
		end
		
		def spaceStationMoves (speed)
		
			return @generator.rand < speed
		
		end
		
	end
	
end

