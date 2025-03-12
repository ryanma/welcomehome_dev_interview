require "rails_helper"

RSpec.describe Import do
  it 'imports data' do
    expect { Import.new.import }.to_not raise_error
  end

  it "loads the CSV file" do
    expect(File).to receive(:read)

    Import.new.import
  end

  xit "creates a list of rooms" do
    expect { Import.new.import }.to change(Room, :count).by(8)
  end
end
