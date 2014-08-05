class Board

	attr_accessor :ships
	attr_accessor :ship_count

	def initialize (ships = [], ship_count = 0)
		@ships = ships
		@ship_count = ship_count
	end

	def total_ship_count 
		@ship_count = ship_count_of_type(:submarine) + 
				ship_count_of_type(:destroyer) + 
				ship_count_of_type(:cruiser) + 
				ship_count_of_type(:battleship) 
	end

	def ship_count_of_type(type)
		if Ship::SHIP_TYPES.include? (type)
			count = 0
			ships.each {|ship| count += 1 if ship.type == type}
			count
		else
			"no ships of this kind"
		end
	end

	def place(ship)
		if ((max_ship_limit_for ship.type) > (ship_count_of_type ship.type)) &&
			!overlap_with_existing_ships?(ship)
			ships << ship
			update_occupied_coordinates_list
			total_ship_count
			"ship placed succesfully"			
		elsif (overlap_with_existing_ships?(ship))
			"a ship cannot be placed on top of another ship"
		else
			false
		end
	end

	def max_ship_limit_for(ship_type)
		case(ship_type)
			when (:submarine) then 4
			when (:destroyer) then 3
			when (:cruiser) then 2
			when (:battleship) then 1
		end
	end

	def overlap_with_existing_ships?(new_ship)
		update_occupied_coordinates_list
		ships.each {|ship| occupied_coordinates << ship.coordinates}
		((occupied_coordinates.flatten) & (new_ship.coordinates)).any? == true
	end

	def occupied_coordinates
		@occupied_coordinates ||= []
	end

	def update_occupied_coordinates_list
		ships.each {|ship| occupied_coordinates << ship.coordinates}
		occupied_coordinates.flatten!
	end

	def ship_segment?(coordinate)
		update_occupied_coordinates_list
		search_array = []
		search_array << coordinate
		((occupied_coordinates.flatten) & (search_array)).any? == true
	end

	def attack(coordinate)

		if legit_coordinate?(coordinate)
			if !previously_attacked?(coordinate)
				update_attacked_coordinates(coordinate)
				if ship_segment?(coordinate) 
					attacked_ship = identify_ship_by(coordinate)
					attacked_ship.take_hit
					update_sunk_ships(attacked_ship)
					:hit
				else
					:miss
				end
			else
				"coordinate has already been attacked"
			end
		else
			"specified coordinate does not exit"
		end
	end

	def identify_ship_by(coordinate)
		identified_ship = ships.select {|ship| ((ship.coordinates & [coordinate]).any? == true)}
		if !identified_ship.empty?
			identified_ship[0]
		else
			"no ship at that coordinate"
		end
	end

	def attacked_coordinates
		@attacked_coordinates ||=[]
	end

	def update_attacked_coordinates(coordinate)
		attacked_coordinates << coordinate		
	end

	def previously_attacked?(coordinate)
		if (attacked_coordinates & [coordinate]).any?
			"coordinate has already been attacked"
			true
		else
			false
		end
	end

	def legit_coordinate?(coordinate)
		in_range?(coordinate) == true
	end

	def in_range?(coordinate)
		(in_row_range?(coordinate) && in_column_range?(coordinate)) == true
	end

	def in_row_range?(coordinate)
		("A".."J").include? (coordinate.slice(0))
	end

	def in_column_range?(coordinate)
		("1".."10").include? (coordinate.slice(1..2))
	end

	def sunk_ships
		@sunk_ships ||= []
	end

	def update_sunk_ships(ship)
		if (ship.status == :sunk) && (!sunk_ships.include?(ship))
			sunk_ships << ship
		end
	end

	def sunk_ships_count
		sunk_ships.count
	end

end






