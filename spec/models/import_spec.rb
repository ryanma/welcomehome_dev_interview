require "rails_helper"

RSpec.describe Import do
  let(:headers) { [ "unit", "floor_plan", "resident", "move_in", "move_out" ] }
  let(:line) { [ "1", "Lake Laogai", "Suki", "1/1/2021", "1/1/2022" ] }
  let(:csv_text) do
    output_string = CSV.generate do |csv|
      csv << headers
      csv << line
    end
    output_string
  end

  it 'reads the data file' do
    expect(File).to receive(:read).with("assets/units-and-residents.csv").and_return(csv_text)

    Import.new.process
  end

  describe 'creating data' do
    let(:csv_text) do
      output_string = CSV.generate do |csv|
        csv << headers
        csv << line
        csv << [ "3", "Earth Kingdom Palace", nil, nil, nil ]
      end
      output_string
    end

    before(:each) do
      allow(File).to receive(:read).and_return(csv_text)
    end

    it 'creates a unit' do
      expect { Import.new.process }.to change(Unit, :count).by(2)
    end

    it 'creates an occupant' do
      expect { Import.new.process }.to change(Occupant, :count).by(1)
    end

    it 'looks up an already existing room and creates new occupants' do
      Unit.create(number: 1, floorplan: "Lake Laogai")

      expect { Import.new.process }.to change(Unit, :count).by(1)
      expect { Import.new.process }.to change(Occupant, :count).by(1)
    end
  end
end
