require_relative 'Weapon'
require_relative 'ShieldBooster'
require_relative 'HangarToUI'

module Deepspace
	class Hangar
		
		attr_reader :maxElements, :weapons, :shieldBoosters
		attr_writer :weapons, :shieldBoosters
		
		# Constructores
		def initialize(capacity)
			@maxElements = capacity
			@weapons = Array.new
			@shieldBoosters = Array.new
		end
		
		def self.newCopy(other)
			aux = new(other.maxElements)
			aux.weapons = Array.new(other.weapons)
			aux.shieldBoosters = Array.new(other.shieldBoosters)
			aux
		end
		
		# Métodos con Visibilidad de Paquete
		def getUIversion
			HangarToUI.new(self)
		end
		
		# Métodos Públicos
		def addWeapon(w)
			if spaceAvailable
				@weapons.push(w)
				@maxElements -= 1
				true
			else
				false
			end
		end
		
		def addShieldBooster(s)
			if spaceAvailable
				@shieldBoosters.push(s)
				@maxElements -= 1
				true
			else
				false
			end
		end
		
		def removeShieldBooster(s)
			if s >= 0 && s < @shieldBoosters.size
				@shieldBoosters.delete_at(s)
			else
				nil
			end
		end
		
		def removeWeapon(w)
			if w >= 0 && w < @weapons.size
				@weapons.delete_at(w)
			else
				nil
			end
		end

		def to_s
			return getUIversion.to_s
		end

		# Métodos Privados
		private 
		def spaceAvailable
			@maxElements > 0
		end
	  
	end
  end

  

