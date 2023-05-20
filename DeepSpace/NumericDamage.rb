require_relative 'Damage'

module Deepspace
class NumericDamage < Damage

    # Volvemos a poner público el constructor de Damage
    public_class_method :new

    def initialize(weapons, shields)
        super(weapons, shields)
    end

    def discardWeapon
		
		if @nWeapons > 0
		  @nWeapons -= 1
		end

	end

    def adjust(w, s)
		new_n_weapons, new_n_shields = 0, 0
		
		# Ajustamos nWeapons
		if @nWeapons > w.length
		  new_n_weapons = w.length
		else
		  new_n_weapons = @nWeapons
		end
		 
		# Ajustamos nShields
		if @nShields > s.length
		  new_n_shields = s.length
		else
		  new_n_shields = @nShields
		end
		
		return NumericDamage.new(new_n_weapons, new_n_shields)
	end

end # Class
end # Module

d = Deepspace::NumericDamage.new(5,6)
puts d.nWeapons
d.discardWeapon
puts d.nWeapons