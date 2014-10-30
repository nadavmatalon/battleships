
module Battleship_Rules

	def check_coordinates?(coordinates)
	 	row_data = coordinates.map { |row_letter| row_letter.to_s.slice(0) }
		column_data = coordinates.map { |column_number| column_number.to_s.slice(1..2) }
		coordinates_inside_rows?(row_data) && coordinates_inside_columns?(column_data)
	end

	def coordinates_inside_rows?(row_data)
		!row_data.map { |row_letter| ("A".."J").include?row_letter }.include?false
	end

	def coordinates_inside_columns?(column_data)
		!column_data.map { |column_number| ("1".."10").include?column_number }.include?false
	end

	def calculate_coordinates(ship_type, position, first_coordinate)
		case(ship_type)
			when (:submarine)
				[first_coordinate]
			when (:destroyer)
				calculate_coordinates_for_destroyer(first_coordinate, position)
			when (:cruiser)
				calculate_coordinates_for_cruiser(first_coordinate, position)
			when (:battleship)
				calculate_coordinates_for_battleship(first_coordinate, position)
		end
	end

	def calculate_coordinates_for_destroyer (first_coordinate, position)
		second_coordinate = get_next_coordinate(first_coordinate, position)
		[first_coordinate, second_coordinate]
	end

	def calculate_coordinates_for_cruiser (first_coordinate, position)
		second_coordinate = get_next_coordinate(first_coordinate, position)
		third_coordinate = get_next_coordinate(second_coordinate, position)
		[first_coordinate, second_coordinate, third_coordinate]
	end

	def calculate_coordinates_for_battleship (first_coordinate, position)
		second_coordinate = get_next_coordinate(first_coordinate, position)
		third_coordinate = get_next_coordinate(second_coordinate, position)
		forth_coordinate = get_next_coordinate(third_coordinate, position)
		[first_coordinate, second_coordinate, third_coordinate, forth_coordinate]
	end

	def get_next_coordinate(start_coordinate, position)
		if position == "horizontal"
			row_designator = start_coordinate.slice(0)
			column_designator = start_coordinate.slice(1..2).next
		else
			row_designator = start_coordinate.slice(0).next
			column_designator = start_coordinate.slice(1..2)
		end
		(row_designator + column_designator).to_sym
	end

end
