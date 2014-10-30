require_relative "./player.rb"
require_relative "./board.rb"
require_relative "./ship.rb"
require_relative "./game.rb"
require_relative "./rules.rb"

class Battleships 

	attr_accessor :game
	attr_accessor :winner

	SUNK_SHIPS_TO_WIN = 10

	include Battleship_Rules

	def run_game
		show_welcome_message
		initialize_new_game
		play_loop_until_game_over
		announce_winner
	end

	def initialize_new_game
		create_game
		setup_players
		show_lets_play_massage
	end

	def show_welcome_message
		clear_screen
		print welcome_message
		hit_any_key_to_continue
	end

	def welcome_message
		"\nWELCOME TO BATTLESHIPS\n"
	end

	def create_game
		@game = Game.new
	end

	def setup_players
		player_setup(game.player_one)
		player_setup(game.player_two)
	end

	def show_lets_play_massage
		clear_screen
		print lets_play_message
	end		

	def lets_play_message
		"Let\'s play!\n\n"
	end

	def play_loop_until_game_over
		while !game_over?
			play_turn
			game.switch_turn	
		end
	end

	def game_over?
		game.is_game_over?
	end

	def announce_winner
		print "GAME OVER\n\n"
		print "The winner is #{winner_name}\n\n"
	end

	def winner_name
		game.get_winner_name
	end

	def play_turn
		coordinate = get_attack_coordinate_from(current_player)
		print attack_result_message(get_attack_result(coordinate))
	end

	def attack_result_message(attack_result)
		"\n#{attack_result}!\n\n"
	end

	def current_turn
		game.current_turn
	end	

	def current_player 
		current_turn == :player_one ? current_player = game.player_one : current_player = game.player_two
	end

	def get_attack_result(coordinate)
		if (current_turn == :player_one)
			attack_result = game.player_one_attack(coordinate)
		else
			attack_result = game.player_two_attack(coordinate)
		end
		attack_result.to_s.capitalize!
	end

	def get_attack_coordinate_from(current_player)
		print attack_coordinate_request_message
		print player_prompt(current_turn)
		coordinate = get_coordinate_from(user_input)
		current_turn == :player_one ? other_player = game.player_two : other_player = game.player_one	
		if current_player.board.legit_coordinate?(coordinate)
			if !(other_player.board.previously_attacked?(coordinate))
				coordinate
			else
				print "\nSorry, this coordinate was already attacked - please try again.\n\n"
				get_attack_coordinate_from(current_player)
			end
		else
			print "\nSorry, this is not a legitimate coordinate - please try again.\n\n"
			get_attack_coordinate_from(current_player)
		end
	end	

	def player_setup(player)
		clear_screen
		print begin_setup_message(player)
		place_ships(player)
		print end_setup_message(player)
		game.switch_turn
		hit_any_key_to_continue
	end

	def attack_coordinate_request_message
		"Please select coordinate to attack:\n\n"
	end

	def begin_setup_message(player)
		"#{player.name.upcase} SETUP\n\n"
	end

	def end_setup_message(player)
		"\nThanks, #{player.name.upcase}!\n\n"
	end

	def place_ships(player)
		place_ship_on_board_of(player, :battleship)
		2.times {place_ship_on_board_of(player, :cruiser)}
		3.times {place_ship_on_board_of(player, :destroyer)}
		4.times {place_ship_on_board_of(player, :submarine)}
	end

	def place_ship_on_board_of(player, ship_type)
		print coordinate_request_message_for(ship_type)
		print player_prompt(current_turn)
		first_coordinate = get_coordinate_from(user_input)
		if player.board.legit_coordinate?(first_coordinate)
			if !(player.board.ship_segment?(first_coordinate))
				position = get_position_selection(ship_type)
				coordinates = calculate_coordinates(ship_type, position, first_coordinate)
				if check_coordinates?(coordinates)
					previous_ship_count = player.board.total_ship_count
					player.board.place(Ship.new(coordinates))
					current_ship_count = player.board.total_ship_count
					if (current_ship_count == previous_ship_count + 1)
						print "\n#{ship_type.to_s.capitalize} successfully placed on board!\n\n\n"
					else
						print "\nSorry, #{ship_type} could not be placed on board - please try again.\n\n"
						place_ship_on_board_of(player, ship_type)
					end
				else
					print "\nSorry, ship must be placed within board boundaries - please try again.\n\n"
					place_ship_on_board_of(player, ship_type)
				end	
			else
				print "\nSorry, this coordinate is already occupied - please try again.\n\n"
				place_ship_on_board_of(player, ship_type)
			end
		else
			print "\nSorry, this is not a legitimate coordinate - please try again.\n\n"
			place_ship_on_board_of(player, ship_type)
		end
	end

	def coordinate_request_message_for(ship_type)
		"Please select initial coordinate for #{ship_type}:\n(coordinate represents the top-left corner of the ship)\n\n"
	end

	def player_prompt(current_turn)
		"#{current_turn} > "
	end

	def get_position_selection(ship_type)
		show_position_selection_message(ship_type)
		position_selection = user_input
		if (position_selection.downcase == "h") 
			position = "horizontal"
		elsif (position_selection.downcase == "v") 
			position = "vertical"
		else 
			print incorrect_selection_message
			get_position_selection(ship_type)
		end
		position
	end

	def incorrect_selection_message
		"\nSorry, incorrect selection - please try again.\n\n"

	end

	def show_position_selection_message(ship_type)
		print "\nplease select position of #{ship_type}"
		print "(H = Horizontal / V = Vertical)\n\n"
		print player_prompt(current_turn)
	end

	def clear_screen
		system "clear" or system "cls"
	end

	def user_input 
		gets.chomp
	end

	def get_coordinate_from(user_input)
		user_input.capitalize.to_sym
	end

	def hit_any_key_to_continue
		print hit_any_key_message
		begin
  			system("stty raw -echo")
  			str = STDIN.getc
		ensure
  			system("stty -raw echo")
		end
	end

	def hit_any_key_message
		"\n(hit any key to continue)\n\n"
	end


end


