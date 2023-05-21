require_relative 'SpaceStation'
require_relative 'SpaceCityToUI'

module Deepspace
class SpaceCity < SpaceStation

    #Override
    def initialize(base,rest)
        super(base.name, SuppliesPackage.new(base.ammoPower,base.fuelUnits, base.shieldPower))
        @weapons = Array.new(base.weapons)
        @nMedals = base.nMedals

		if base.pendingDamage != nil
			@pendingDamage = Damage.copy(base.pendingDamage)
		end

		if base.hangar != nil
			@hangar = Hangar.newCopy(base.hangar)
		end

		@shieldBoosters = Array.new(base.shieldBoosters)
        @base = base
        @collaborators = Array.new(rest)
    end

    #Override
    def fire
        total = super

        for i in @collaborators do
            total += i.fire
        end

        total
    end

    #Override
    def protection
        total = super

        for i in @collaborators do
            total += i.protection
        end

        total
    end 

    #Override
    def setLoot(loot)
        super
        return Transformation::NOTRANSFORM
    end

    #Override
    def getUIversion
        return SpaceCityToUI.new(self)
    end

    attr_reader :collaborators

end # class
end # module
