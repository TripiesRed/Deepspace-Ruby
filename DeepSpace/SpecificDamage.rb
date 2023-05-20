require_relative 'Damage'

module Deepspace
class SpecificDamage < Damage

    # Volvemos a poner público el constructor de Damage
    public_class_method :new

    def initialize(wl, shields)
        super(wl.length, shields)
        @weapons = wl
    end

    def discardWeapon(w)
		weapon_type = w.type
		weapon_index = arrayContainsType(@weapons, weapon_type)
		
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

            i = 0
            while i < new_n_weapons do
                n = arrayContainsType(w[i])
                if(n != -1)
                    new_wl.add(@weapons[n])
                end
            end
            
        end

		else
		  new_n_weapons = @nWeapons
          new_wl = @weapons
		end
		 
		# Ajustamos nShields
		if @nShields > s.length
		  new_n_shields = s.length
		else
		  new_n_shields = @nShields
		end
		
		return SpecificDamage.new(new_wl, new_n_shields)
	  end

end # Class

end # Module


