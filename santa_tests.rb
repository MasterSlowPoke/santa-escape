require "./santa_game.rb"
# require "minitest/autorun"

# class TestMeme < Minitest::Test
# 	def test_every_input
# 		game = SantaGame.new
#
# 		game.run_command { puts "Run"; game.run_handler }
# 		game.run_command { puts "Fight"; game.fight_handler }
# 		game.run_command { puts "Give Cookie"; game.give_handler }
# 		game.run_command { puts "Hide"; game.hide_handler }
# 		game.run_command { puts "Help"; game.help_handler }
# 		game.run_command { puts "Items"; game.items_handler } 
# 		game.run_command { puts "Surrender"; game.quit_handler }
# 		game.run_command { puts "asdf"; game.unknown_handler }
# 		game.run_command { puts "status"; game.status_handler }
# 		game.run_command { puts "look"; game.look_handler }
# 		game.run_command { puts "bioterrorism"; game.nuke_handler }
# 	end
# end

## Win game
def test_win_game
# 	game = SantaGame.new

# 	result = nil

# 	until result
# 		until game.santa.distance > 84
# 			game.run_command { puts "Run"; game.run_handler }
# 		end
# 		until game.santa.distance < 15
# 			result = game.run_command { puts "Fight"; game.fight_handler }
			
# 			while game.santa.health < 75 && game.santa.health > 0
# 				result = game.run_command { puts "Give Cookie"; game.give_handler }
# 			end

# 			break if result
# 		end
# 	end

	game.show_ending(result)
end

## Win game by brute force
def test_win_by_brute_force
	game = SantaGame.new
	result = nil

	until result
		until game.santa.distance > 84
			game.run_command(0.1) { puts "Run"; game.run_handler }
		end
		until game.santa.distance < 15
				result = game.run_command(0.1) { puts "Fight"; game.fight_handler }
			break if result
		end
		break if result
	end

	game.show_ending(result)
end

# test_every_input
# test_win_game
# test_win_by_brute_force