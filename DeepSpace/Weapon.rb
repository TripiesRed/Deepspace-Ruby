module Deepsace
	class Weapon
		 attr_reader :type, :uses

		 DEFAULT_RETURN_VALUE
	  
		 def initialize(name, type, uses)
		 
		   @name = name.to_f
		   @type = type.to_f
		   @uses = uses.to_f
		 
		 end
	  
		 def self.newCopy(other)
		  
		   new(other.name, other.type, other.uses)
		 
		 end

		 def power()

		     type.power

		 end

		 def useIt()

		     if uses > 0 

		         uses = uses -1
		         self.power()
		     
		     else

		         DEFAULT_RETURN_VALUE
		     
		     end
		 end
		 
	end
end  
