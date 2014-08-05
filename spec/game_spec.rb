require "./lib/game.rb"

describe Game do 

	let(:game) {Game.new}
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

	def player_one_begins
		allow(game).to receive(:get_random_player_name) {:player_one}
	end

	it "is initialized with two players" do
		expect(game.player_count).to eq 2
	end

	it "sets first turn to play randomly" do
		player_one_begins
		expect(game.current_turn).to eq :player_one
	end

	it "knows whose turn it currently is (player_one/player_two)" do
		player_one_begins
		expect(game.current_turn).to eq :player_one
	end


	it "can switch turns between player_one and player_two" do
		player_one_begins
		expect(game.current_turn).to eq :player_one
		game.switch_turn
		expect(game.current_turn).to eq :player_two
	end

	it "enables player one to place a ship on her/his own board" do
		game.player_one_place(submarine_1)
		expect(game.player_one.board.ships[0]).to eq submarine_1
	end

	it "enables player two to place a ship on her/his own board" do
		game.player_two_place(submarine_1)
		expect(game.player_two.board.ships[0]).to eq submarine_1
	end

	it "can register an attack by player one"	do	
		game.player_two.board.place(submarine_1)
		expect(game.player_one_attack(:A5)).to eq :miss
		expect(game.player_one_attack(:A1)).to eq :hit
	end
	
	it "can register an attack by player two"	do	
		game.player_one.board.place(submarine_1)
		expect(game.player_two_attack(:A5)).to eq :miss
		expect(game.player_two_attack(:A1)).to eq :hit
	end

end

