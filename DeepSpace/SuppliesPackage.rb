module Deepspace	
class SuppliesPackage
	
	attr_reader :ammoPower, :fuelUnits, :shieldPower

	def initialize(ammoPower, fuelUnits, shieldPower)
		@ammoPower = ammoPower.to_f
		@fuelUnits = fuelUnits.to_f
		@shieldPower = shieldPower.to_f
	end

	def self.newCopy(other)
		new(other.ammoPower, other.fuelUnits, other.shieldPower)
	end

end
end
