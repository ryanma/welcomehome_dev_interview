require "rails_helper"

RSpec.describe Unit do
  let!(:unit) { Unit.create(number: 1) }

  it 'has a required unit number' do
    expect(unit.valid?).to be true
    expect(Unit.new().valid?).to be false
  end

  it 'has a unique number' do
    expect(Unit.new(number: 1).valid?).to be false
  end
end
