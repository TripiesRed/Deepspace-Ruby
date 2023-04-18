module Deepspace

	class Damage
	  
	  attr_reader :n_shields, :n_weapons, :weapons
	  
	  # Constructor
	  def initialize(shields, weapons)
		@n_shields = shields
		@n_weapons = weapons
		@weapons = []
	  end
	  
	  def self.copy(orig)
		new(orig.n_shields, orig.n_weapons, orig.weapons.clone)
	  end
	  
	  # Métodos Visibilidad de Paquete
	  def get_UIversion
		DamageToUI.new(self)
	  end
	  
	  # Métodos Privados
	  def arrayContainsType(w, t)
		index = -1
		if w.include?(t)
		  index = w.index(t)
		end
		return index
	  end
	  
	  # Métodods Públicos
	  def adjust(w, s)
		new_n_weapons, new_n_shields = 0, 0
		
		# Ajustamos nWeapons
		if @n_weapons > w.length
		  new_n_weapons = w.length
		else
		  new_n_weapons = @n_weapons
		end
		 
		# Ajustamos nShields
		if @n_shields > s.length
		  new_n_shields = s.length
		else
		  new_n_shields = @n_shields
		end
		
		return Damage.new(new_n_shields, new_n_weapons)
	  end
	  
	  def discard_weapon(w)
		weapon_type = w.get_type
		weapon_index = arrayContainsType(@weapons, weapon_type)
		
		if !@weapons.empty? && weapon_index != -1
		  @weapons.delete_at(weapon_index)
		elsif @n_weapons > 0
		  @n_weapons -= 1
		end
	  end
	  
	  def discard_shield_booster
		if @n_shields > 0
		  @n_shields -= 1
		end
	  end
	  
	  def has_no_effect
		@n_shields == 0 && @n_weapons == 0
	  end
	  
	  def set_weapons(w)
		@weapons = w.clone
	  end
	  
	  def to_s
		"Shields: #{@n_shields}, Weapons: #{@n_weapons}, Weapon Types: #{@weapons.to_s}"
	  end
  
	end # class Damage
  
  end # module Deepspace  