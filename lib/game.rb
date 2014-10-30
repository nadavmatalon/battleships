require_relative "./rules.rb"

class Game

	include Battleship_Rules
	
	attr_accessor :players

	SUNK_SHIPS_TO_WIN = 10

	def initialize (players = [], current_turn = :player_one)
		@players = players
		create_players
		@current_turn = current_turn
	end

	def player_count
		players.count
	end

	def current_turn
		@current_turn
	end

	def current_player
		current_turn == :player_one ? @current_player = player_one : player_two
	end

	def switch_turn
		if current_turn == :player_one 
			@current_turn = :player_two 
		else
			@current_turn = :player_one
		end
	end

	def get_random_player_name
		players.sample.name
	end

	def set_turn(player_name)
		@current_turn = player_name
	end

	def player_one
		@player_one
	end

	def player_two
		@player_two
	end

	def create_players
		create_player_one
		create_player_two
		@players << player_one
		@players << player_two
	end

	def create_player_one
		@player_one = Player.new(:player_one)
	end

	def create_player_two
		@player_two = Player.new(:player_two)
	end

	def player_one_attack(coordinate)
		player_two.board.attack(coordinate)
	end

	def player_two_attack(coordinate)
		player_one.board.attack(coordinate)
	end	

	def player_one_place(ship)
		player_one.board.place(ship)
	end

	def player_two_place(ship)
		player_two.board.place(ship)
	end

	def sunk_ship_count(player)
		player.board.sunk_ships_count
	end

	def is_game_over?
		(sunk_ship_count(player_one) == SUNK_SHIPS_TO_WIN) || (sunk_ship_count(player_two) == SUNK_SHIPS_TO_WIN)
	end

	def get_winner_name
		if player_one.board.sunk_ships_count == SUNK_SHIPS_TO_WIN 
			:player_two
		elsif player_two.board.sunk_ships_count == SUNK_SHIPS_TO_WIN
			:player_one
		else
			"no winner yet"
		end
	end

end




