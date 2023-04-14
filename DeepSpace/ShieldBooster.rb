module Deepspace
	class ShieldBooster

		@@UNIT=1

		def initialize (name, boost, uses)
			
			@name = name
			@boost = boost
			@uses = uses
			
		end

		def self.newCopy (other)
			
			new(other.name, other.boost, other.uses)

		end

		attr_reader :name, :boost, :uses

		def useIt 
		
			if @uses > 0
				@uses -= @@UNIT
				@boost
			
			else 
				@@UNIT
			end
		end

	end
	
end

