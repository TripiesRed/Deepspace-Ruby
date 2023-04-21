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
		@nMedals = 0
		@pendingDamage = nil
		@hangar = nil
		@shieldBoosters = Array.new
		@weapons = Array.new

	end

	def receiveHangar(h)

		if(@hangar.nil? == true)
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

	def discardHangar

		@hangar = nil

	end

	def discardShieldBooster

	end

	def discardShieldBoosterInHangar

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

	def mountShieldBooster(i)

		@shieldBoosters.push(@hangar.removeShieldBooster(i))

	end

	def mountWeapon(i)

		@weapons.push(@hangar.removeWeapon(i))

	end

	def cleanUpMountedItems

		i = 0
		while i < @weapons.size
		
			if(@weapons.at(i).uses == 0)
				@weapons[i] = nil
			end

			i += 1
		end

		i = 0
		while i < @shieldBoosters.size
		
			if(@shieldBoosters.at(i).uses == 0)
				@shieldBoosters[i] = nil
			end

			i += 1
		end

	end

	def getSpeed

		speed = @fuelUnits/@@MAXFUEL

		return speed

	end

	def move

		if(@fuelUnits > 0)
			@fuelUnits -= getSpeed
		end

	end

	def fire

	end

	def protection

	end
	
	def setLoot(loot)

	end

	def setPendingDamage(d)

		@pendingDamage = d.adjust(@weapons, @shieldBoosters)

	end

	def validState
		valid = false

		if(@pendingDamage.hasNoEffect || @pendingDamage == nil)
			valid = true	
		
		end

		return valid

	end
	
	def getUIversion
	
		return SpaceStationToUI.new(self)
	
	end

	def to_s

		line = "Name: " + @name +  "\nMedals: " + @nMedals.to_s + "\nFuelUnits: " + @fuelUnits.to_s
		line = line + "\nAmmoPower: " + @ammoPower.to_s + "\nShieldPower: " + @shieldPower.to_s + "\n-Hangar\n" + @hangar.to_s

		i = 0
		line2 = "\n-ShieldBoosters"
		while  i < @shieldBoosters.size do
			line2 += "\n-Shield " + i.to_s + "-\n" + @shieldBoosters[i].to_s
			i += 1
		end

		line2 += "\n-Weapons"

		i = 0
		while  i < @weapons.size do
			line2 += "\n-Weapon " + i.to_s + "-\n" + @weapons[i].to_s
			i += 1
		end

		line += line2

		line

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




