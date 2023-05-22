require_relative 'ShieldToUI'

module Deepspace
	class ShieldBooster

		@@UNIT=1

		attr_reader :name, :boost, :uses

		def initialize (name, boost, uses)
			
			@name = name
			@boost = boost
			@uses = uses
			
		end

		def self.newCopy (other)
			
			new(other.name, other.boost, other.uses)

		end

		def useIt 
		
			if @uses > 0
				@uses -= @@UNIT
				@boost
			
			else 
				@@UNIT
			end
		end

		def to_s

			"Name: " + @name + "\nBoost: " + @boost.to_s + "\nUses: " + @uses.to_s

		end
		
		def getUIversion
			return ShieldToUI.new(self)
		end

		def to_s
			return getUIversion.to_s
		end

	end
end

