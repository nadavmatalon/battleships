class Player

	attr_accessor :board
	attr_accessor :name

	def initialize(name, board = Board.new)
		@name = name
		@board = board
	end

end