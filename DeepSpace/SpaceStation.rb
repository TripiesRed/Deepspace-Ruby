require_relative 'SpaceStationToUI'
require_relative 'Damage'
require_relative 'Loot'
require_relative 'SuppliesPackage'
require_relative 'Weapon'
require_relative 'ShieldBooster'
require_relative 'Hangar'

module Deepspace

class SpaceStation
	
	attr_reader :name, :nMedals, :ammoPower, :fuelUnits, \
      :shieldPower, :shieldBoosters, :hangar, :weapons, \
      :pendingDamage

	@@MAXFUEL = 100
	@@SHIELDLOSSPERUNITSHOT = 0.1

	def initialize (n, supplies ) #Constructor

		@name = n
		@ammoPower = supplies.ammoPower
		@fuelUnits = supplies.fuelUnits
		@shieldPower = supplies.shieldPower
		@nMedals = nil
		@pendingDamage = nil
		@hangar = nil
		@shieldBoosters = Array.new
		@weapons = Array.new

	end

	def cleanUpMountedItems



	end

	def discardHangar

		@hangar = nil

	end

	def discarShieldBooster

	end

	def discarShieldBoosterInHangar

		if(@hangar.nil? == false)
			@hangar.removeShieldBooster
		end

	end

	def discardWeapon

	end

	def discardWeaponInHangar

		if(@hangar.nil? == false)
			@hangar.removeWeapon
		end

	end

	def fire

	end

	def mountShieldBooster(i)

	end

	def mountWeapon(i)

		@weapons

	end

	def move

	end

	def protection

	end

	def receiveHangar(h)

		if(@hangar.nil == true)
			@hangar = h
		end

	end

	def receiveShieldBooster(s)

		if(@hangar.nil? == false)
			return @hangar.addShieldBooster(s)
		
		else return false
		
		end
	end

	def receiveShot(shot)

	end

	def receiveSupplies(s)

		@ammoPower += s.ammoPower
		@fuelUnits += s.fuelUnits
		@shieldPower += s.shieldPower

	end

	def receiveWeapon(w)

		if(@hangar.nil? == false)
			return @hangar.addWeapon(w)
		
		else return false
		
		end

	end
	
	def setLoot(loot)

	end

	def setPendingDamage(d)

		@pendingDamage = d.adjust(@weapons, @shieldBoosters)

	end

	def validState

	end
	
	def getUIversion
	
		return SpaceStationToUI.new(self)
	
	end

	#Métodos Privados
	private

	def assignFuelValue (f)
		
		if(f < @@MAXFUEL)
			@fuelUnits = f
		end

	end

	def cleanPendingDamage

		if(@pendingDamage.hasNoEffect)
			@pendingDamage = nil
		end

	end

end

end



