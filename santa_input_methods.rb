# Extends SantaGame to handle all input cases

module SantaInputMethods
	# CONSTS
	MAX_ROCK_DISTANCE = 90
	OPTIMAL_ROCK_DISTANCE = 45
	MISS_CHANCE = 10
	CRIT_CHANCE = 30
	LONG_RANGE_PENALTY = 10
	COOKIE_THRESHOLD = 75

	def run_handler
		puts get_string(:run, @santa.withdraw_after_run)
		display_regeneration
	end

	def fight_handler
		roll = 0
		roll = rand(100) unless @santa.distance > MAX_ROCK_DISTANCE
		roll = [0, (roll - 10)].max if @santa.distance > OPTIMAL_ROCK_DISTANCE

		case roll
		when 0..MISS_CHANCE
			puts get_string(:fight_miss) + (@santa.distance > MAX_ROCK_DISTANCE ? get_string(:fight_out_of_range) : "")
			
			display_regeneration
		when MISS_CHANCE..99-CRIT_CHANCE
			@santa.suffer_glancing_hit
			puts get_string(:fight_glance) + get_string(:damage, @santa.health)
		else
			@santa.suffer_crushing_hit
			puts get_string(:fight_crush) + get_string(:damage, @santa.health)
		end
		return :you_win if @santa.health == 0

		distance_delta = @santa.advance_after_fight
		puts get_string(:fight_move, distance_delta, foot_or_feet(distance_delta))
	end

	def hide_handler
		distance_delta = @santa.advance_after_hide
		puts get_string(:hide, distance_delta, foot_or_feet(distance_delta))
		display_regeneration
	end

	def give_handler
		if @santa.health > COOKIE_THRESHOLD
			distance_delta = @santa.advance_after_rejected_cookie
			puts get_string(:reject_cookie, distance_delta, foot_or_feet(distance_delta))
			display_regeneration
		elsif @santa.cookies_eaten >= 2
			@santa.suffer_fatal_hit
			puts get_string(:diabetes_1)
			puts get_string(:diabetes_2)
			puts get_string(:diabetes_3)
			return :you_win;
		else
			health_delta = @santa.eat_cookie
			puts get_string(:accept_cookie, health_delta, @santa.health)
		end
	end

	def quit_handler(input = "")
		if (input[0] == "n")
			puts get_string(:confirm_north)
			result = get_input[0]

			unless result == "y"
				distance_delta = @santa.advance_after_confusion
				puts get_string(:reject_north, distance_delta, foot_or_feet(distance_delta))
				display_regeneration
				return nil
			end
		end
		puts get_string(:surrender)
		return :you_lose
	end

	def help_handler
		puts get_string(:help_lang) + get_string(:help_base)
	end

	def items_handler
		puts get_string(:items, 3 - @santa.cookies_eaten, (3 - @santa.cookies_eaten) > 1 ? "s" : "" )
	end

	def nuke_handler
		puts get_string(:nuke)
		@santa.suffer_fatal_hit
		return :you_win
	end

	def look_handler
		puts get_look_string
	end

	def status_handler
		puts get_string(:status, @santa.distance, foot_or_feet(@santa.distance), @santa.health)
	end

	def unknown_handler
		distance_delta = @santa.advance_after_confusion
		puts get_string(:unknown, distance_delta, foot_or_feet(distance_delta))
		help_handler
		display_regeneration
	end
end