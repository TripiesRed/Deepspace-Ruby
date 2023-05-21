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
	  
	  # Métodods Públicos
	  def copy(orig)
		aux = new(orig.nWeapons, orig.nShields)
		aux.weapons = Array.new(orig.weapons)
		aux
	  end
	  
	  def discardShieldBooster
		if @nShields > 0
		  @nShields -= 1
		end
	  end
	  
	  def hasNoEffect
		@nShields == 0 && @nWeapons == 0
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

	  # Dado que es una clase abstracta, hacemos privado el constructor
	  private_class_method :new

	end # class Damage
  
  end # module Deepspace  