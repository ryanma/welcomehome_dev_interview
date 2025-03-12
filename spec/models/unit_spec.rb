require "rails_helper"

RSpec.describe Unit do
  let(:unit) { Unit.create(number: 1, floorplan: "Omashu", occupant_name: "Aang", move_in_date: Date.parse("2020-06-01")) }
  let(:unit_2) { Unit.create(number: 2, floorplan: "Wan Shi Tong's Library", move_in_date: Date.parse("2020-07-01")) }

  it 'has a required unit number' do
    expect(unit.valid?).to be true
    expect(Unit.new().valid?).to be false
  end

  it 'has a unique number' do
    expect(Unit.new(number: 1).valid?).to be false
  end

  it 'has a required floorplan name' do
    expect(unit).to be_valid
    expect(Unit.new(number: 2).valid?).to be false
  end

  it 'has an occupant name' do
    expect(unit.occupant_name).to eq "Aang"
  end

  it 'knows if the unit is vacant' do
    expect(unit.vacant?).to be false

    unit2 = Unit.create(number: 2, floorplan: "Ba Sing Se")
    expect(unit2.vacant?).to be true
  end

  it 'reports it move in date' do
    expect(unit.move_in_date).to eq Date.parse("2020-06-01")
    expect(unit_2.move_in_date).to eq Date.parse("2020-07-01")
  end
end
