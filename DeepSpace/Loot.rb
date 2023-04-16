require_relative 'LootToUI'

module Deepspace
	class Loot

		def initialize (supplies, weapons, shields, hangars, medals)
			
			@nSupplies = supplies
			@nWeapons = weapons
			@nShields = shields
			@nHangars = hangars
			@nMedals = medals
			
		end

		attr_reader :nSupplies, :nWeapons, :nShields, :nHangars, :nMedals
		
		def getUIversion
		
			return LootToUI.new(self)
		
		end

	end
	
end
