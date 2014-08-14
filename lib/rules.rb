
module Battleship_Rules

	def check_coordinates?(coordinates)
	 	row_data = coordinates.map {|e| e.to_s.slice(0)}		
		column_data = coordinates.map {|e| e.to_s.slice(1..2)}		
		coordinates_inside_rows?(row_data) && coordinates_inside_columns?(column_data) == true
	end

	def coordinates_inside_rows?(row_data)
		result = 0
		row_data.each {|row| ("A".."J") === row ? "" : result += 1}
		result == 0 ? true : false
	end

	def coordinates_inside_columns?(column_data)
		result = 0
		column_data.each {|column| ("1".."10") === column ? "" : result += 1}
		result == 0 ? true : false
	end

	def get_next_coordinate(start_coordinate, position)
		if (position == "horizontal")
			row_designator = start_coordinate.slice(0)
			column_designator = start_coordinate.slice(1..2).next
			coordinate = (row_designator + column_designator).to_sym	
		else
			row_designator = start_coordinate.slice(0).next
			column_designator = start_coordinate.slice(1..2)
			coordinate = (row_designator + column_designator).to_sym
		end
		coordinate
	end

	def calculate_coordinates(ship_type, position, first_coordinate)
		coordinates = []
		coordinates << first_coordinate
		case(ship_type)
			when (:destroyer)
				second_coordinate = get_next_coordinate(first_coordinate, position)
				coordinates << second_coordinate

			when (:cruiser)
				second_coordinate = get_next_coordinate(first_coordinate, position)
				coordinates << second_coordinate
				third_coordinate = get_next_coordinate(second_coordinate, position)
				coordinates << third_coordinate

			when (:battleship)
				second_coordinate = get_next_coordinate(first_coordinate, position)
				coordinates << second_coordinate
				third_coordinate = get_next_coordinate(second_coordinate, position)
				coordinates << third_coordinate
				forth_coordinate = get_next_coordinate(third_coordinate, position)
				coordinates << forth_coordinate
		end
		coordinates
	end
end