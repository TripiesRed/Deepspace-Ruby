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

		weapon_index = arrayContainsType(@weapons, w)

		if !@weapons.empty? && weapon_index != -1
		  @weapons.delete_at(weapon_index)
          @nWeapons -= 1
		end

	end

    def adjust(w, s)
		new_n_weapons, new_n_shields = 0, 0
		new_wl = []

		# Ajustamos nWeapons
		if @nWeapons > w.length
			new_n_weapons = w.length
			new_wl = Array.new(w)

		else
			new_n_weapons = @nWeapons
			i = 0
			while i < w.length do
				n = arrayContainsType(@weapons, w[i])
				if(n != -1)
					new_wl.add(@weapons[n])
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

end # Class

end # Module


