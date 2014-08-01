class Santa
	attr_reader :health
	attr_reader :distance
	attr_reader :cookies_eaten

	# METHODS
	def initialize(distance = 30, health = 100)
		@distance = distance
		@health = health
		@cookies_eaten = 0
	end

	def health=(new_health)
		@health = new_health
		@health = [@health, 0].max
		@health = [@health, 100].min
	end

	def is_close?
		@distance <= 75
	end

	def is_breathing_down_your_neck?
		@distance <= 16
	end

	def regenerate
		heal_wounds(:normal)
	end

	def eat_cookie
		heal_wounds(:cookie)
	end

	def suffer_glancing_hit
		damage(:glance)
	end

	def suffer_crushing_hit
		damage(:crush)
	end

	def suffer_fatal_hit
		damage(:fatal)
	end

	def advance_after_fight
		move(:fight)
	end

	def advance_after_hide
		move(:hide)
	end

	def withdraw_after_run
		move(:run)
	end

	def advance_after_rejected_cookie
		move(:cookie)
	end

	def advance_after_confusion
		move(:unknown)
	end

	def to_s
		"Santa Stats: " + @health.to_s + "% health, " + @distance.to_s + "ft away, " + @cookies_eaten.to_s + " cookies eaten."
	end

	private
	# CONSTS
	REGNERATION_AMOUNTS = {
		cookie: (20..50),
		normal: (1..10),
	}
	MOVEMENT_AMOUNTS = {
		run: (4..10),
		hide: (-25..-9),
		fight: (-15..-6),
		unknown:(-5..-1),
		cookie: (-30..-10),
	}
	DAMAGE_AMOUNTS = {
		glance: (3..10),
		crush: (11..25),
		fatal: (100..100),
	}

	# returns the absolute value of the move delta
	def move(type = :unknown)
		movement = rand(MOVEMENT_AMOUNTS[type])
		@distance += movement
		movement.abs
	end

	def damage(type = :none)
		damage = rand(DAMAGE_AMOUNTS[type])
		self.health -= damage
		damage
	end

	# returns the amount regenerated. does nothing if at full health
	def heal_wounds(type = :normal)
		return 0 if @health >= 100

		@cookies_eaten += 1 if type == :cookie

		health_delta = rand(REGNERATION_AMOUNTS[type])
		self.health += health_delta
	
		health_delta
	end
end