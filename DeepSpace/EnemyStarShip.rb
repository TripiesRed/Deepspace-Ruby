require_relative 'EnemyToUI'
require_relative 'Loot'
require_relative 'Damage'
require_relative 'ShotResult'

module Deepspace
	class EnemyStarShip
		attr_reader :name, :loot, :damage, :ammoPower, :shieldPower

		def initialize(n, a, s, l, d)
			@name = n
			@ammoPower = a
			@shieldPower = s
			@loot = l
			@damage = d
		end

		def self.newCopy(e)
			new(e.name, e.ammoPower, e.shieldPower, e.loot, e.damage)
		end

		def fire()
			@ammoPower
		end

		def protection()
			@shieldPower
		end

		def receiveShot(shot)
			if @shieldPower < shot
				ShotResult::DONOTRESIST
			else
				ShotResult::RESIST
			end
		end

		def getUIversion()
			EnemyToUI.new(self)
		end
	
		def to_s
			return getUIversion.to_s
		end
  
	end
  end
  