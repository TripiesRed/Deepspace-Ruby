require_relative 'WeaponToUI'
require_relative 'WeaponType'

module Deepspace
	class Weapon

		attr_reader :type, :uses, :name

		@@DEFAULT_RETURN_VALUE=1
	
		def initialize(name, type, uses)
		
			@name = name
			@type = type
			@uses = uses
		
		end
	
		def self.newCopy(other)
		
			new(other.name, other.type, other.uses)
		
		end

		def power()
			@type.power
		end

		def useIt()

			if @uses > 0 
				@uses = @uses -1
				self.power()
			
			else
				@@DEFAULT_RETURN_VALUE
			
			end
		end
		
		def getUIversion
	
			return WeaponToUI.new(self)
	
		end

		def to_s

			"Name: " + @name + "\nType: " + @type.to_s + "\nUses: " + @uses.to_s

		end
		 
	end
end  
