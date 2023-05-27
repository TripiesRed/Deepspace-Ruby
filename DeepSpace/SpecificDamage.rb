require_relative 'Damage'
require_relative 'SpecificDamageToUI'

module Deepspace
class SpecificDamage < Damage

    # Volvemos a poner público el constructor de Damage
    public_class_method :new

    def initialize(wl, shields)
        super(wl.length, shields)
        @weapons = Array.new(wl)
    end

    def discardWeapon(w)

		if !@weapons.empty? && @weapons.include?(w.type)
		  @weapons.delete_at(@weapons.index(w.type))
          @nWeapons -= 1
		end

	end

    def adjust(w, s)
		new_n_weapons, new_n_shields = 0, 0
		new_wl = []

		# Ajustamos nWeapons
		if @nWeapons > w.length
			new_n_weapons = w.length
			new_wl = Array.new

			for i in w
				new_wl << i.type
			end

		else
			new_n_weapons = @nWeapons
			i = 0
			while i < w.length do
				if(@weapons.include?(w[i].type))
					new_wl.push(w[i].type)
				end
				i +=1
			end
		end
		 
		# Ajustamos nShields
		if @nShields > s.length
		  	new_n_shields = s.length
		else
		  	new_n_shields = @nShields
		end
		
		return SpecificDamage.new(new_wl, new_n_shields)
	end

	def getUIversion
		return SpecificDamageToUI.new(self)
	end

	def to_s
		return getUIversion.to_s
	end

	#Métodos privados
	private

	def arrayContainsType(w, t)
		index = -1

		for i in w
			if(i.type = t)
				index = w.index(i)
			end
		end
		
		return index
	end

end # Class

end # Module


