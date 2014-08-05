require "./lib/player.rb"

describe Player do 

	let(:player) {Player.new("player")}
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

	it "has an empty board" do
		expect(player.board.total_ship_count).to eq 0

	end

	it "can place a battleship on the board" do
		player.board.place(battleship_1)
		expect(player.board.total_ship_count).to eq 1
	end

	it "can attack a specific coordinate on the board" do
		player.board.place(submarine_1)
		expect(player.board.attack(:A5)).to eq :miss
		expect(player.board.attack(:A1)).to eq :hit
	end

end