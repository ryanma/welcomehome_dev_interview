require "rails_helper"

RSpec.describe Occupant do
  let(:beifong_estate) { Unit.create(number: 1, floorplan: "Beifong Estate") }
  let!(:toph) { Occupant.create(
    name: "Toph",
    move_in_date: "2020-01-01",
    move_out_date: "2021-01-01",
    unit: beifong_estate,
  ) }

  it 'must belong to a unit' do
    expect(toph.unit).to eq beifong_estate

    expect(Occupant.new(name: "Master Yu").valid?).to be false
  end

  it 'has a name' do
    expect(toph.name).to eq "Toph"
  end

  it "requires a name" do
    expect(Occupant.new().valid?).to_not be true
  end

  it 'has a move in date' do
    expect(toph.move_in_date).to eq Date.parse("2020-01-01")
  end

  it 'has a move out date' do
    expect(toph.move_out_date).to eq Date.parse("2021-01-01")
  end
end
