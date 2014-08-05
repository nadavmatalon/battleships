require "./lib/ship.rb"

describe Ship do

	# let(:ship) { Ship.new }

	it "can be initialized as a battleship" do
		ship = Ship.new([:A1, :A2, :A3, :A4])
		expect(ship.type).to eq :battleship
	end

	it "can be initialized as a cruiser" do
		ship = Ship.new([:A1, :A2, :A3])
		expect(ship.type).to eq :cruiser
	end

	it "can be initialized as a destroyer" do
		ship = Ship.new([:A1, :A2])
		expect(ship.type).to eq :destroyer
	end

	it "can be initialized as a submarine" do
		ship = Ship.new([:A1])
		expect(ship.type).to eq :submarine
	end

	it "has a size of 4 if it\'s a battleship" do
		ship = Ship.new([:A1, :A2, :A3, :A4])
		expect(ship.size).to eq 4
	end		

	it "has a size of 3 if it\'s a cruiser" do
		ship = Ship.new([:A1, :A2, :A3])
		expect(ship.size).to eq 3
	end		

	it "has a size of 2 if it\'s a destroyer" do
		ship = Ship.new([:A1, :A2])
		expect(ship.size).to eq 2
	end		

		it "has a size of 1 if it\'s a submarine" do
		ship = Ship.new([:A1])
		expect(ship.size).to eq 1
	end		

	it "must be initialized with a specific size" do
		expect(lambda{Ship.new}).to raise_error(ArgumentError)
	end


	it 'is floating when first created' do
		ship = Ship.new([:A1, :A2, :A3, :A4])
		expect(ship.status).to eq :floating
	end

	it "knows if it\'s floating" do

		ship = Ship.new([:A1, :A2, :A3, :A4])
		expect(ship.floating?).to be true
		expect(ship.sunk?).to be false
	end

	it "can sink" do
		ship = Ship.new([:A1])
		ship.take_hit
		expect(ship.status).to eq :sunk		
	end

	it "knows if it\'s sunk" do
		ship = Ship.new([:A1])
		ship.take_hit
		expect(ship.sunk?).to be true
		expect(ship.floating?).to be false
	end

	it "cannot be hit after sinking" do
		ship = Ship.new([:A1])
		ship.take_hit
		expect(ship.take_hit).to eq "ship already sunk"
	end

	it "keeps track of the hits it takes" do
		ship = Ship.new([:A1, :A2, :A3, :A4])
		expect(ship.hit_count).to eq 0
		ship.take_hit
		expect(ship.hit_count).to eq 1
	end

	it "sinks if its hit count reaches its size" do
		ship = Ship.new([:A1, :A2])
		2.times {ship.take_hit}
		expect(ship.status).to eq :sunk
	end

	it "has coordinates" do 
		sea_breeze = Ship.new([:A1])
		expect(sea_breeze.coordinates).to eq [:A1]
	end

	it "its coordinates must be given an array" do
		ship = Ship.new([:A1, :A2])	
		expect(ship.coordinates.is_a? Array).to be true
	end

	it "isn't initialized if not given acceptable coordinates" do
		expect(lambda{Ship.new("a")}).to raise_error(ArgumentError)
	end

	it "can be horizotal" do
		ship = Ship.new([:A8, :A9, :A10])
		expect(ship.horizontal?).to be true
		expect(ship.vertical?).to be false
	end

	it "can be vertical" do
		ship = Ship.new([:A10, :B10, :C10])
		expect(ship.vertical?).to be true
		expect(ship.horizontal?).to be false
	end

	it "must be either vertical or horizontal" do
		expect(lambda{Ship.new([:A1, :B2, :C3, :D4])}).to raise_error(ArgumentError)
	end


	it "must be initialized inside grid bounds" do
		ship = Ship.new([:A8, :A9, :A10])
		expect(ship.inside_grid?).to be true
	end

	it "cannot be initialized outside of the grid" do
		expect(lambda{Ship.new([:A9, :A10, :A11])}).to raise_error(ArgumentError) 

	end

	it "must be placed on consecutive coordinates" do
		ship_1 = Ship.new([:A8, :A9, :A10])
		ship_2= Ship.new([:B8, :C8, :D8])
		ship_3= Ship.new([:E5])
		expect(ship_1.consecutive?).to eq :yep
		expect(ship_2.consecutive?).to eq :yep
		expect(ship_3.consecutive?).to eq :yep
	end

	it "cannot be placed on non-consecutive coordinates" do
		expect(lambda{Ship.new([:A1, :A5, :A10])}).to raise_error(ArgumentError)
	end

end

