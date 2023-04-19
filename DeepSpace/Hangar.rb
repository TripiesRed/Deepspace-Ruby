module Deepspace
	class Hangar
		
		attr_reader :maxElements, :weapons, :shield_boosters
		
		# Constructores
		def initialize(capacity)
		@maxElements = capacity
		@weapons = []
		@shield_boosters = []
		end
		
		def self.copy(other)
		new(other.max_elements, other.weapons.clone, other.shield_boosters.clone)
		end
		
		# Métodos con Visibilidad de Paquete
		def getUIversion
		HangarToUI.new(self)
		end
		
		# Métodos Privados
		private def spaceAvailable
		@maxElements > 0
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
			@shield_boosters.push(s)
			@maxElements -= 1
			true
		else
			false
		end
		end
		
		def removeShieldBooster(s)
		if s >= 0 && s < @shield_boosters.size
			@shield_boosters.delete_at(s)
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

			line1 = "MaxElements: " + @maxElements.to_s

			i = 0
			line2 = "\n-ShieldBoosters(in Hangar) "
			while  i < @shield_boosters.size do
				line2 += "\n-Shield " + i.to_s + "-\n" + @shield_boosters[i].to_s
				i += 1
			end

			line2 += "\n-Weapons(in Hangar) "

			i = 0
			while  i < @weapons.size do
				line2 += "\n-Weapon " + i.to_s + "-\n" + @weapons[i].to_s
				i += 1
			end

			line1 += line2

			line1

		end
	  
	end
  end
  