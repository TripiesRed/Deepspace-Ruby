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
		myProtection = protection()

  		if myProtection >= shot
    		@shieldPower -= SHIELDLOSSPERUNITSHOT * shot

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

		if(@hangar.nil? == false)
			return @hangar.addWeapon(w)
		
		else return false
		
		end

	end

	def discardHangar

		@hangar = nil

	end

	def discardShieldBooster

		size = shieldBoosters.size

		if i >= 0 && i < size
			shieldBoosters.remove(i)

			if pendingDamage != nil
				pendingDamage.discardShieldBooster()
				cleanPendingDamage()
			end
		end
	end

	def discardShieldBoosterInHangar

		if(@hangar.nil? == false)
			@hangar.removeShieldBooster
		end

	end

	def discardWeapon(i)

		size = weapons.size

		if i >= 0 && i < size
			w = weapons.delete_at(i)

			if pendingDamage != nil
				pendingDamage.discardWeapon(w)
				cleanPendingDamage()
			end
		end			

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

		size = weapons.size
		factor = 1

		
		(0...size).each do |i|
  			w = weapons[i]
  			factor *= w.useIt
		end

		return ammoPower * factor
	end

	def protection
		size = shieldBoosters.size
		factor = 1.0

		(0...size).each do |i|
 			s = shieldBoosters[i]
  			factor *= s.useIt
		end

		return shieldPower * factor

	end
	
	def setLoot(loot)

		dealer = CardDealer.getInstance

  		h = loot.getNHangars

  		if h > 0
    		hangar = dealer.nextHangar
    		self.receiveHangar(hangar)
  		end

  		elements = loot.getNSupplies

  
  		elements.times do |i|
    		sup = dealer.nextSuppliesPackage
    		self.receiveSupplies(sup)
  		end

  		elements = loot.getNWeapons

  		elements.times do |i|
    		weap = dealer.nextWeapon
    		self.receiveWeapon(weap)
  		end

  		elements = loot.getNShields

  		elements.times do |i|
    		sh = dealer.nextShieldBooster
    		self.receiveShieldBooster(sh)
  		end

  		@nMedals += loot.getNMedals
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




