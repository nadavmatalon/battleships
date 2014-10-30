require "./lib/rules.rb"

class RulesContainer
	include Battleship_Rules 
end

describe RulesContainer do

	let(:rules) { RulesContainer.new }

	it "knows if coordinates are inside gird rows" do
		expect(rules.coordinates_inside_rows?(["A"])).to be true
	end

	it "knows if coordinates are outside gird rows" do
		expect(rules.coordinates_inside_rows?(["K"])).to be false
	end

	it "knows if coordinates are inside gird columns" do
		expect(rules.coordinates_inside_columns?(["1"])).to be true
	end

	it "knows if coordinates are outside gird columns" do
		expect(rules.coordinates_inside_columns?(["11"])).to be false
	end

	it "knows if coordinates are inside grid" do
		expect(rules.check_coordinates?([:A1])).to be true
	end

	it "knows if coordinates are outside grid" do
		expect(rules.check_coordinates?([:K1])).to be false
	end

	it "can calucalte location of the next horizontal coordinate" do
		next_coordinate = rules.get_next_coordinate(:A1, "horizontal")
		expect(next_coordinate).to eq :A2
	end

	it "can calucalte location of the next vertical coordinate" do
		next_coordinate = rules.get_next_coordinate(:A1, "vertical")
		expect(next_coordinate).to eq :B1
	end

	it "can calucalte coordinates for horizontal submarine" do
		coordinates = rules.calculate_coordinates(:submarine, "horizontal", :A1)
		expect(coordinates).to eq [:A1]
	end

	it "can calucalte coordinates for horizontal destroyer" do
		coordinates = rules.calculate_coordinates(:destroyer, "horizontal", :A1)
		expect(coordinates).to eq [:A1, :A2]
	end

	it "can calucalte coordinates for horizontal cruiser" do
		coordinates = rules.calculate_coordinates(:cruiser, "horizontal", :A1)
		expect(coordinates).to eq [:A1, :A2, :A3]
	end

	it "can calucalte coordinates for horizontal battleship" do
		coordinates = rules.calculate_coordinates(:battleship, "horizontal", :A1)
		expect(coordinates).to eq [:A1, :A2, :A3, :A4]
	end

	it "can calucalte coordinates for vertical submarine" do
		coordinates = rules.calculate_coordinates(:submarine, "vertical", :A1)
		expect(coordinates).to eq [:A1]
	end

	it "can calucalte coordinates for vertical destroyer" do
		coordinates = rules.calculate_coordinates(:destroyer, "vertical", :A1)
		expect(coordinates).to eq [:A1, :B1]
	end

	it "can calucalte coordinates for vertical cruiser" do
		coordinates = rules.calculate_coordinates(:cruiser, "vertical", :A1)
		expect(coordinates).to eq [:A1, :B1, :C1]
	end

	it "can calucalte coordinates for vertical battleship" do
		coordinates = rules.calculate_coordinates(:battleship, "vertical", :A1)
		expect(coordinates).to eq [:A1, :B1, :C1, :D1]
	end

end

