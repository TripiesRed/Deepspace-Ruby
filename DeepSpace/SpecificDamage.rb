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
				n = arrayContainsType(@weapons, w[i].type)
				if(n != -1)
					new_wl.push(@weapons[n].type)
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

		wt = Array.new

		for i in w
			wt << i.type
		end

		if wt.include?(t)
			index = wt.index(t)
		end
		
		return index
	end

end # Class

end # Module


