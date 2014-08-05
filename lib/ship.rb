class Ship

	SHIP_TYPES = [:battleship, :cruiser, :destroyer, :submarine]

	def initialize(coordinates)
		@coordinates = coordinates
		@size = set_size_according_to_coordinates(coordinates)
		@type = set_type_according_to_size(size)
		@position = vertical_or_horizontal_check
		inside_grid?
		consecutive?
		@status = :floating
		@hit_count = 0
	end

	def type
		@type
	end

	def set_type_according_to_size(size)
		case(size)
			when (1) then @type = :submarine	
			when (2) then @type = :destroyer
			when (3) then @type = :cruiser
			when (4) then @type = :battleship
		end
	end

	def coordinates
		@coordinates
	end

	def inside_grid?
		inside_rows? && inside_columns? ? true : (raise ArgumentError.new("ship must be located inside grid"))
	end

	def position
		@position
	end

	def set_size_according_to_coordinates(coordinates)
		if (coordinates.is_a? Array)
			coordinates.length
		else
		    raise ArgumentError.new("coordinates must be given in an array")	
		end
	end

	def size
		@size
	end

	def status
		@status
	end

	def hit_count
		@hit_count
	end

	def floating?
		@status == :floating
	end

	def sunk?
		@status == :sunk
	end

	def take_hit
		if hit_count != size 
			@hit_count += 1 
			hit_count == 1 ? message_modifier = "" : message_modifier = "s" 
			@hit_count == size ? @status = :sunk : "#{@type} has taken #{hit_count} hit#{message_modifier}"
		else
			"ship already sunk"
		end
	end

	def horizontal? 
		row_data.all? {|e| e == row_data[0]}
	end

	def vertical?
		column_data.all? {|e| e == column_data[0]}
	end

	def vertical_or_horizontal_check
		if vertical?
			:vertical
		elsif horizontal?
			:horizontal
		else
			raise ArgumentError.new("ship must be straight (vertical or horizontal)")	
		end
	end

	def inside_rows?
		result = 0
		row_data.each {|row| ("A".."J") === row ? "" : result += 1}
		result == 0 ? true : false
	end

	def inside_columns?
		result = 0
		column_data.each {|column| ("1".."10") === column ? "" : result += 1}
		result == 0 ? true : false
	end

	def row_data
 		row_data = coordinates.map {|e| e.to_s.slice(0)}		
	end

	def column_data
 		column_data = coordinates.map {|e| e.to_s.slice(1..2)}		
	end

	def consecutive?
		index = 1
		result = 0
		(size-1).times do
			horizontal? ? data = column_data : data = row_data
			result += 1 if !(data[index].to_s == data[index-1].next.to_s) 
			index += 1
		end
  		result == 0 ? :yep : (raise ArgumentError.new("ship must be placed on consecutive coordinates"))
	end

end




