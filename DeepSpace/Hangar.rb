module Deepspace
	class Hangar
	  
	  attr_reader :max_elements, :weapons, :shield_boosters
	  
	  # Constructores
	  def initialize(capacity)
		@max_elements = capacity
		@weapons = []
		@shield_boosters = []
	  end
	  
	  def initialize_copy(other)
		@max_elements = other.max_elements
		@weapons = other.weapons.clone
		@shield_boosters = other.shield_boosters.clone
	  end
	  
	  # Métodos con Visibilidad de Paquete
	  def get_ui_version
		HangarToUI.new(self)
	  end
	  
	  # Métodos Privados
	  private def space_available?
		@max_elements > 0
	  end
	  
	  # Métodos Públicos
	  def add_weapon(w)
		if space_available?
		  @weapons.push(w)
		  @max_elements -= 1
		  true
		else
		  false
		end
	  end
	  
	  def add_shield_booster(s)
		if space_available?
		  @shield_boosters.push(s)
		  @max_elements -= 1
		  true
		else
		  false
		end
	  end
	  
	  def remove_shield_booster(s)
		if s >= 0 && s < @shield_boosters.size
		  @shield_boosters.delete_at(s)
		else
		  nil
		end
	  end
	  
	  def remove_weapon(w)
		if w >= 0 && w < @weapons.size
		  @weapons.delete_at(w)
		else
		  nil
		end
	  end
	  
	end
  end
  