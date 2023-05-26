require_relative 'SpaceStationToUI'
require_relative 'Damage'
require_relative 'Loot'
require_relative 'SuppliesPackage'
require_relative 'Weapon'
require_relative 'ShieldBooster'
require_relative 'Hangar'
require_relative 'CardDealer'
require_relative 'ShotResult'
require_relative 'Transformation'

module Deepspace

class SpaceStation
	
	attr_accessor :name, :nMedals, :ammoPower, :fuelUnits, \
      :shieldPower, :shieldBoosters, :hangar, :weapons, \
      :pendingDamage

	@@MAXFUEL = 100
	@@SHIELDLOSSPERUNITSHOT = 0.1

	def initialize (n, supplies) #Constructor
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
	
	def self.newCopy(other)
		sup = SuppliesPackage.new(other.ammoPower, other.fuelUnits,other.shieldPower)
		aux = new(other.name, sup)
		aux.nMedals = other.nMedals

		aux.shieldBoosters = Array.new(other.shieldBoosters)
		aux.weapons = Array.new(other.weapons)

		if other.pendingDamage != nil
			aux.pendingDamage = Damage.copy(other.pendingDamage)
		end

		if other.hangar != nil
			aux.hangar = Hangar.newCopy(other.hangar)
		end
		
		aux
	end

	def receiveHangar(h)

		if(@hangar == nil)
			@hangar = Hangar.newCopy(h)
		end

	end

	def receiveShieldBooster(s)

		if(@hangar != nil)
			return @hangar.addShieldBooster(s)
		
		else return false
		
		end
	end

	def receiveShot(shot)
		myProtection = protection()

  		if myProtection >= shot
    		@shieldPower -= @@SHIELDLOSSPERUNITSHOT * shot

    		if @shieldPower < 0.0
      			@shieldPower = 0.0
    		end

    		return ShotResult::RESIST
  		else
    		@shieldPower = 0.0

    	return ShotResult::DONOTRESIST
  		end
	end

	def receiveSupplies(s)

		@ammoPower += s.ammoPower
		@fuelUnits += s.fuelUnits
		@shieldPower += s.shieldPower

	end

	def receiveWeapon(w)

		if(@hangar != nil)
			@hangar.addWeapon(w)
		
		else return false
		
		end

	end

	def discardHangar
		@hangar = nil
	end

	def discardShieldBooster(i)

		size = shieldBoosters.size

		if i >= 0 && i < size
			@shieldBoosters.delete_at(i)

			if @pendingDamage != nil
				@pendingDamage.discardShieldBooster()
				cleanPendingDamage()
			end
		end
	end

	def discardShieldBoosterInHangar(i)

		if(@hangar != nil)
			@hangar.removeShieldBooster(i)
		end

	end

	def discardWeapon(i)

		size = @weapons.size

		if i >= 0 && i < size
			w = @weapons.delete_at(i)

			if @pendingDamage != nil
				@pendingDamage.discardWeapon(w)
				cleanPendingDamage()
			end
		end			

	end

	def discardWeaponInHangar(i)

		if(@hangar != nil)
			@hangar.removeWeapon(i)
		end

	end

	def mountWeapon(i)
		if(@hangar != nil)
			h = @hangar.removeWeapon(i)
			if(h != nil)
				@weapons.push(h)
			end
		end
	end

	def mountShieldBooster(i)
		if(@hangar != nil)
			sb = @hangar.removeShieldBooster(i)
			if(sb!= nil)
				@shieldBoosters.push(sb)
			end
		end
	end

	def cleanUpMountedItems

		i = 0
		while i < @weapons.size
		
			if(@weapons.at(i).uses == 0)
				@weapons.delete_at(i)
			end

			i += 1
		end

		i = 0
		while i < @shieldBoosters.size
		
			if(@shieldBoosters.at(i).uses == 0)
				@shieldBoosters.delete_at(i)
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

		size = @weapons.size
		factor = 1.0

		(0...size).each do |i|
  			factor *= @weapons[i].useIt
		end

		return @ammoPower * factor
	end

	def protection
		size = @shieldBoosters.size
		factor = 1.0

		i = 0
		while i < size
			factor *= @shieldBoosters.at(i).useIt
			i+=1
		end

		return @shieldPower * factor

	end
	
	def setLoot(loot)

		dealer = CardDealer.instance

  		h = loot.nHangars

  		if h > 0
    		hang = dealer.nextHangar
    		self.receiveHangar(hang)
  		end

  		elements = loot.nSupplies
		i = 0
  
  		while i < elements 
    		sup = dealer.nextSuppliesPackage
    		self.receiveSupplies(sup)
			i += 1
  		end

  		elements = loot.nWeapons
		i = 0

  		while i < elements
    		weap = dealer.nextWeapon
    		self.receiveWeapon(weap)
			i += 1
  		end

  		elements = loot.nShields
		i = 0
		while i < elements
    		sh = dealer.nextShieldBooster
    		self.receiveShieldBooster(sh)
			i += 1
  		end

  		@nMedals += loot.nMedals

		if(loot.efficient)
			return Transformation::GETEFFICIENT

		elsif(loot.spaceCity)
			return Transformation::SPACECITY

		else
			return Transformation::NOTRANSFORM
		end

	end

	def setPendingDamage(d)
		wt = Array.new

		for i in @weapons
			wt << i.type
		end

		@pendingDamage = d.adjust(wt, @shieldBoosters)
	end

	def validState
		valid = false

		if(@pendingDamage == nil)
			valid = true
		elsif(@pendingDamage.hasNoEffect)	
			valid = true
		end

		return valid

	end
	
	def getUIversion
		return SpaceStationToUI.new(self)
	end

	def to_s
		getUIversion.to_s
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