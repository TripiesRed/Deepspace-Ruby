require_relative 'SpaceStation'
require_relative 'PowerEfficientSpaceStationToUI'

module Deepspace
class PowerEfficientSpaceStation < SpaceStation

    @@EFFICIENCYFACTOR = 1.10

    #Override
    def fire
        fire = super
        return (fire * @@EFFICIENCYFACTOR)
    end

    #Override
    def protection
        protect = super
        return (protect * @@EFFICIENCYFACTOR)
    end

    #Override
    def setLoot(loot)
        transf = super

        if(transf == Transformation::SPACECITY)
            return Transformation::NOTRANSFORM

        else 
            return transf

        end
    end

    #Override
    def getUIversion
        return PowerEfficientSpaceStationToUI.new(self)
    end

end # class
end # module
