require_relative 'LootToUI'

module Deepspace
	class Loot

		def initialize (supplies, weapons, shields, hangars, medals, ef=false, city=false)
			
			@nSupplies = supplies
			@nWeapons = weapons
			@nShields = shields
			@nHangars = hangars
			@nMedals = medals
			@getEfficient = ef
			@spaceCity = city
			
		end

		attr_reader :nSupplies, :nWeapons, :nShields, :nHangars, :nMedals, :getEfficient,
					:spaceCity
		
		def getUIversion
		
			return LootToUI.new(self)
		
		end

	end # class
	
end # module
