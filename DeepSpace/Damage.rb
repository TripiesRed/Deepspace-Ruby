require_relative 'WeaponType'
require_relative 'DamageToUI'

module Deepspace

	class Damage
	  
	  attr_reader :nShields, :nWeapons, :weapons
	  attr_writer :weapons
	  
	  # Constructor
	  def initialize(weapons, shields)
		@nShields = shields
		@nWeapons = weapons
		@weapons = []
	  end
	  
	  def self.newCopy(orig)
		aux = new(orig.nWeapons, orig.nShields)
		aux.weapons = Array.new(orig.weapons)
		aux
	  end

	  def self.newSpecificWeapons(wl, s)
		aux = new(wl.length, s)
		aux.weapons = wl
		aux
	  end

	  def self.newNumericWeapons(n, s)
		new(n, s)
	  end
	  
	  def getUIversion
		DamageToUI.new(self)
	  end
	  
	  # Métodods Públicos
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
		
		return Damage.new(new_n_shields, new_n_weapons)
	  end
	  
	  def discardWeapon(w)
		weapon_type = w.type
		weapon_index = arrayContainsType(@weapons, weapon_type)
		
		if !@weapons.empty? && weapon_index != -1
		  @weapons.delete_at(weapon_index)
		elsif @nWeapons > 0
		  @nWeapons -= 1
		end
	  end
	  
	  def discardShieldBooster
		if @nShields > 0
		  @nShields -= 1
		end
	  end
	  
	  def hasNoEffect
		@nShields == 0 && @nWeapons == 0
	  end
	  
	  def setNWeapons(w)
		@weapons = w.clone
	  end
	  
	  def to_s
		"Shields: #{@nShields}, Weapons: #{@nWeapons}, Weapon Types: #{@weapons.to_s}"
	  end

	  # Métodos Privados
	  private

	  def arrayContainsType(w, t)
		index = -1
		if w.include?(t)
		  index = w.index(t)
		end
		return index
	  end

	end # class Damage
  
  end # module Deepspace  