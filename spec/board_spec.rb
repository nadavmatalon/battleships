require "./lib/board.rb"

describe Board do 

	let(:board) {Board.new}
	let(:submarine_1) {Ship.new([:A1])}
	let(:submarine_2) {Ship.new([:A3])}
	let(:submarine_3) {Ship.new([:A5])}
	let(:submarine_4) {Ship.new([:A7])}
	let(:submarine_5) {Ship.new([:A9])}
	let(:destroyer_1) {Ship.new([:C1, :C2])}
	let(:destroyer_2) {Ship.new([:C4, :C5])}
	let(:destroyer_3) {Ship.new([:C7, :C8])}
	let(:destroyer_4) {Ship.new([:I1, :I2])}
	let(:cruiser_1) {Ship.new([:E1, :E2, :E3])}
	let(:cruiser_2) {Ship.new([:E5, :E6, :E7])}
	let(:cruiser_3) {Ship.new([:I4, :I5, :I6])}
	let(:battleship_1) {Ship.new([:G1, :G2, :G3, :G4])}
	let(:battleship_2) {Ship.new([:G6, :G7, :G8, :G9])}


	it "does not have any ship when initialized" do
		expect(board.total_ship_count).to eq 0
		expect(board.ships).to eq []
	end

	it "can have a ship placed on it" do		
		expect(board.place(submarine_1)).to eq "ship placed succesfully"
	end
	
	it "knows which ships are currently placed on it" do
		board.place(submarine_1)	
		expect(board.ships).to eq [submarine_1]
	end

	it "knows how many ships are placed on it" do
		board.place(submarine_1)	
		expect(board.total_ship_count).to eq 1
	end

	it "can have more than one ship placed on it" do
		board.place(submarine_1)	
		board.place(battleship_1)	
		expect(board.ships).to eq [submarine_1, battleship_1]
	end

	it "knows how many ships are currently placed on it" do
		board.place(submarine_1)	
		board.place(cruiser_1)	
		board.place(battleship_1)	
		expect(board.total_ship_count).to eq 3
	end

	it "knows how many submaries are currently placed on it" do
		board.place(submarine_1)	
		board.place(submarine_2)	
		board.place(cruiser_1)	
		board.place(battleship_1)			
		expect(board.ship_count_of_type(:submarine)).to eq 2
	end

	it "cannot have more than 1 battleship placed on it" do
		board.place(battleship_1)
		expect(board.place(battleship_2)).to eq false
	end

	it "cannot have more than 2 cruisers placed on it" do
		board.place(cruiser_1)
		board.place(cruiser_2)
		expect(board.place(cruiser_3)).to eq false
	end

	it "cannot have more than 3 destroyers placed on it" do
		board.place(destroyer_1)
		board.place(destroyer_2)
		board.place(destroyer_3)
		expect(board.place(destroyer_4)).to eq false
	end

	it "cannot have more than 4 submarines placed on it" do
		board.place(submarine_1)
		board.place(submarine_2)
		board.place(submarine_3)
		board.place(submarine_4)
		expect(board.place(submarine_5)).to eq false
	end

	it "cannot have one ship placed on top of another ship" do
		ship_1 = Ship.new([:A1, :A2])
		ship_2 = Ship.new([:A2, :A3])
		ship_3 = Ship.new([:A4, :A5])
		ship_4 = Ship.new([:C1, :D1, :E1])
		ship_5 = Ship.new([:D1, :D2, :D3])
		board.place(ship_1)
		message_1 = "a ship cannot be placed on top of another ship"
		message_2 = "ship placed succesfully"
		expect(board.place(ship_2)).to eq message_1
		expect(board.place(ship_3)).to eq message_2
		expect(board.place(ship_4)).to eq message_2
		expect(board.place(ship_5)).to eq message_1
	end

	it "knows which coordinates are occupied by ships" do
		board.place(submarine_1)
		expect(board.ship_segment?(:A1)).to be true
		expect(board.ship_segment?(:B1)).to be false
	end

	it "knows if a ship was hit" do
		board.place(submarine_1)
		expect(board.attack(:A1)).to eq :hit
	end

	it "knows if a ship was missed" do
		board.place(submarine_1)
		expect(board.attack(:A5)).to eq :miss
	end

	it "updates a ship\'s hit count if that ship is hit" do
		board.place(submarine_1)
		board.attack(:A1)
		expect(submarine_1.hit_count).to eq 1
	end

	it "knows if a ship has sunk" do
		board.place(destroyer_1)
		expect(destroyer_1.status).to eq :floating
		expect(board.sunk_ships_count).to eq 0
		board.attack(:C1)
		expect(destroyer_1.hit_count).to eq 1
		expect(board.sunk_ships_count).to eq 0
		board.attack(:C2)
		expect(destroyer_1.hit_count).to eq 2
		expect(destroyer_1.status).to eq :sunk
		expect(board.sunk_ships_count).to eq 1
		puts board.sunk_ships
	end

	it "knows if a coordinate is inside the board" do
		expect(board.legit_coordinate?(:A1)).to be true
		expect(board.legit_coordinate?(:Z1)).to be false
		expect(board.legit_coordinate?(:J10)).to be true
		expect(board.legit_coordinate?(:A11)).to be false
	end

	it "knows if a coordinate was previously attacked" do
		expect(board.previously_attacked?(:A1)).to be false
		board.attack(:A1)
		expect(board.previously_attacked?(:A1)).to be true
	end

	it "does not allow the same coordinate to be attacked twice" do
		board.attack(:A1)
		message = "coordinate has already been attacked"
		expect(board.attack(:A1)).to eq message
	end

	it "can idetify a ship by one of it's coordinates" do
		board.place(destroyer_1)
		expect(board.identify_ship_by(:C1)).to eq destroyer_1
	end

	it "knows if a coordinate isn't occupied by a ship" do
		expect(board.identify_ship_by(:A1)).to eq "no ship at that coordinate"
	end

end

