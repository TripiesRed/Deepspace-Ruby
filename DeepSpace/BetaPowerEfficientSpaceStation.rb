require_relative 'PowerEfficientSpaceStation'
require_relative 'Dice'
require_relative 'BetaPowerEfficientSpaceStationToUI'

module Deepspace
class BetaPowerEfficientSpaceStation < PowerEfficientSpaceStation

    @@EXTRAEFFICIENCY = 1.2

    #Override
    def fire 
        dice = Dice.new
        fire = super

        if(dice.extraEfficiency)
            return (fire * @@EXTRAEFFICIENCY)

        else 
            return fire
        end
    end

    #Override
    def getUIversion
        return BetaPowerEfficientSpaceStationToUI.new(self)
    end

end # class
end # module