require "./santa.rb"
require "./santa_gfx.rb"
require "./santa_strings.rb"
require "./santa_input_methods.rb"

class SantaGame 
	include SantaGfx
	include SantaStrings
	include SantaInputMethods

	attr_reader :santa

	# HELPER METHODS
	def foot_or_feet(numfeet)
		numfeet > 1 ? get_string(:feet) : get_string(:foot)
	end

	# METHODS
	def initialize()
		@santa = Santa.new
		@language = choose_language
		@state = generate_state_string
	end

	def get_input
		input = gets.chomp! 
		input = input.split[0]
		input = "" if input.nil?

		print "\a" #im annoyin

		input.downcase
	end

	def run(suppress_splash = false, result = nil)
		game_result = result
		show_splash_screens unless suppress_splash

		until game_result 
			puts @state
			game_result = process_input(get_input)
			@state = generate_state_string
		end

		show_ending(game_result)
	end

	def process_input(input)
		puts ""

		game_result = case input
		when "run", "r", "e", "s", "w", "east", "south", "west"
			run_handler
		
		when "fight", "f", "hit"
			fight_handler

		when "hide", "h"
			hide_handler

		when "give", "g", "cookie", "c"
			give_handler

		when "surrender", "exit", "quit", "north", "n"
			quit_handler(input)
		
		when "help", "", "?"
			help_handler

		when "look", "l"
			look_handler

		when "status", "s", "info"
			status_handler

		when "items", "i", "inventory", "item"
			items_handler

		when "bioterrorism"
			nuke_handler

		when "language", "lang"
			@language = choose_language
			nil

		else
			unknown_handler
		end
		
		return :you_lose if @santa.distance <= 0

		puts LOOP_SEPERATOR

		game_result
	end
	
	def display_regeneration
		puts get_string(:regenerate, @santa.health) if @santa.regenerate > 0
	end

	def run_command(delay = 0.5)
		puts @state
		puts ""
		result = yield
		puts LOOP_SEPERATOR

		sleep delay
		@state = generate_state_string
		result
	end
end