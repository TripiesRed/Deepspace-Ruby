#Dependencias
require_relative 'GameUniverseToUI'
require_relative 'CardDealer'
require_relative 'Dice'
require_relative 'GameStateController'
require_relative 'GameState'
require_relative 'CombatResult'
require_relative 'ShotResult'
require_relative 'GameCharacter'
require_relative 'EnemyStarShip'
require_relative 'SpaceStation'
require_relative 'BetaPowerEfficientSpaceStation'
require_relative 'PowerEfficientSpaceStation'
require_relative 'SpaceCity'


module Deepspace
class GameUniverse

	@@WIN = 10

	attr_reader :gameState, :currentStation, :currentEnemy

	def initialize ()
		
		@gameState = GameStateController.new
		@turns = 0
		@dice = Dice.new
		@currentEnemy = nil
		@currentStation = nil
		@spaceStations = Array.new
		@currentStationIndex = -1
		@haveSpaceCity = false

	end	

	def mountShieldBooster(i)

		if(@gameState.state == GameState::INIT || 
			@gameState.state == GameState::AFTERCOMBAT)
			
			@currentStation.mountShieldBooster(i)
		end 

	end

	def mountWeapon(i)
		if(@gameState.state == GameState::INIT || 
			@gameState.state == GameState::AFTERCOMBAT)
			@currentStation.mountWeapon(i)
		end 

	end

	def discardHangar
		
		if(@gameState.state == GameState::INIT || 
			@gameState.state == GameState::AFTERCOMBAT)
			@currentStation.discardHangar
		end

	end

	def discardShieldBooster(i)
		
		if(@gameState.state == GameState::INIT || 
			@gameState.state == GameState::AFTERCOMBAT)
			@currentStation.discardShieldBooster(i)
		end

	end

	def discardShieldBoosterInHangar(i)
		
		if(@gameState.state == GameState::INIT || 
			@gameState.state == GameState::AFTERCOMBAT)
			@currentStation.discardShieldBoosterInHangar(i)
		end

	end

	def discardWeapon(i)

		if(@gameState.state == GameState::INIT || 
			@gameState.state == GameState::AFTERCOMBAT)
			@currentStation.discardWeapon(i)
		end

	end

	def discardWeaponInHangar(i) 

		if(@gameState.state == GameState::INIT || 
		   @gameState.state == GameState::AFTERCOMBAT)
		   @currentStation.discardWeaponInHangar(i)
		end

	end

	def haveAWinner
		thereisAWinner = false

		if(@currentStation.nMedals == @@WIN)
			thereisAWinner = true
		end

		return thereisAWinner

	end

	def init(names)

		if(@gameState.state == GameState::CANNOTPLAY)
			dealer = CardDealer.instance

			i = 0 
			while i < names.size do 
				supplies = dealer.nextSuppliesPackage
				station = SpaceStation.new(names[i], supplies)

				@spaceStations.push(station)

				nh = @dice.initWithNHangars
				nw = @dice.initWithNWeapons
				ns = @dice.initWithNShields
				lo = Loot.new(0,nw,ns,nh,0)

				station.setLoot(lo)

				i += 1

			end

			@currentStationIndex = @dice.whoStarts(names.size)
			@currentStation = @spaceStations[@currentStationIndex]

			@currentEnemy = dealer.nextEnemy

			@gameState.next(@turns, @spaceStations.size)

		end

	end 

	def nextTurn
		
		if(state == GameState::AFTERCOMBAT)

			if(@currentStation.validState)

				@currentStationIndex = (@currentStationIndex+1) % @spaceStations.length
				@turns += 1

				@currentStation = @spaceStations[@currentStationIndex]
				@currentStation.cleanUpMountedItems

				dealer = CardDealer.instance

				@currentEnemy = dealer.nextEnemy

				@gameState.next(@turns, @spaceStations.length)

				return true

			else return false
			
			end


		else return false
		
		end

	end

	def state
		return @gameState.state
	end

	def combat 
		
		if( state == GameState::BEFORECOMBAT || state == GameState::INIT)
			return combatGo(@currentStation, @currentEnemy)

		else return CombatResult::NOCOMBAT

		end

	end

	def combatGo(station, enemy)
		
		ch = @dice.firstShot
		enemyWins = nil
		combatResult = nil

		if(ch == GameCharacter::ENEMYSTARSHIP)
			fire = enemy.fire
			result = station.receiveShot(fire)

			if(result == ShotResult::RESIST)
				fire = station.fire 
				result = enemy.receiveShot(fire)
				enemyWins = (result == ShotResult::RESIST)

			else enemyWins = true

			end
		
		else 
			fire = station.fire
			result = enemy.receiveShot(fire)
			enemyWins = (result == ShotResult::RESIST)
		
		end
		
		if(enemyWins)

			s = station.getSpeed
			moves = @dice.spaceStationMoves(s)

			if(!moves)

				damage = enemy.damage
				station.setPendingDamage(damage)
				combatResult = CombatResult::ENEMYWINS
			
			else 
				station.move
				combatResult = CombatResult::STATIONESCAPES

			end
		
		else
			aLoot = enemy.loot
			t = station.setLoot(aLoot)
			if(t == Transformation::GETEFFICIENT)
				makeStationEfficient()

			elsif (t == Transformation::SPACECITY)
				createSpaceCity()
			
			end

			combatResult = CombatResult::STATIONWINS

		end

		@gameState.next(@turns, @spaceStations.length)
		#nextTurn()
		return combatResult

	end

	def createSpaceCity
		if(!@haveSpaceCity)
			@currentStation = SpaceCity.new(@currentStation, @spaceStations)
			@spaceStations[@currentStationIndex] = @currentStation
			@haveSpaceCity = true
		end
	end

	def makeStationEfficient
		extraeff = @dice.extraEfficiency

		if(extraeff)
			@currentStation = BetaPowerEfficientSpaceStation.newCopy(@currentStation)
			@spaceStations[@currentStationIndex] = @currentStation

		else
			@currentStation = PowerEfficientSpaceStation.newCopy(@currentStation)
			@spaceStations[@currentStationIndex] = @currentStation
		end
	end

	def getUIversion
		return GameUniverseToUI.new(@currentStation, @currentEnemy)
	end

	def to_s
		return getUIversion.to_s
	end

end
end
