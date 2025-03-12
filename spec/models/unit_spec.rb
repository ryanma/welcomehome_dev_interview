require "rails_helper"

RSpec.describe Unit do
  let!(:unit) { Unit.create(number: 1, floorplan: "Omashu", occupant_name: "Aang") }

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
end
