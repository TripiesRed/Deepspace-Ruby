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

module Deepspace
class GameUniverse

	@@WIN = 10

	attr_reader :gameState

	def initialize ()
		
		@gameState = GameStateController.new
		@turns = 0
		@dice = Dice.new
		@currentEnemy = nil
		@currentStation = nil
		@spaceStations = Array.new
		@currentStationIndex = 0

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
		
	end

	def nextTurn
	
	end

	def combat 

	end

	def combatGo(station, enemy)
		
	end


	def getUIversion
		
		return GameUniverseToUI.new(self)
	
	end

end
end