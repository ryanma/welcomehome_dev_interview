require 'rails_helper'

RSpec.describe RentRollReport do
  let(:date) { Date.parse '2020-01-01' }
  let!(:occupied_unit) do
    Unit.create(
      number: 1,
      floorplan: 'Kiyoshi Island',
      occupants: [
        Occupant.new(
          name: 'Aang',
          move_in_date: Date.parse('2019-11-01'),
          move_out_date: Date.parse('2020-01-31'),
        ),
      ]
    )
  end
  let!(:leased_unit) do
    Unit.create(
      number: 2,
      floorplan: 'Chin Village',
      occupants: [
        Occupant.new(
          name: 'Katara',
          move_in_date: '2020-03-01',
        ),
      ]
    )
  end
  let(:rent_roll) { RentRollReport.new(date) }
  let(:report) { rent_roll.report }

  it 'is run for a given date' do
    expect(RentRollReport.new(date).date).to eq date
  end

  it 'lists units in order' do
    expect(RentRollReport.new(Date.today).units).to eq [ occupied_unit, leased_unit ]
  end

  it 'includes unit data' do
    expect(report.first[0]).to eq 1
  end

  it 'includes floorplan data' do
    expect(report.first[1]).to eq 'Kiyoshi Island'
  end

  it 'provides the names of occupants' do
    expect(report.first[2][0][:name]).to eq 'Aang'
  end

  it 'provides status of residents' do
    expect(report.first[2][0][:status]).to eq 'current'
    expect(report[1][2][0][:status]).to eq 'future'
  end

  it 'does not include former occupants' do
    Occupant.create(
      unit: occupied_unit,
      name: 'Kiyoshi',
      move_in_date: Date.parse("2018-01-01"),
      move_out_date: Date.parse("2019-01-01")
    )

    expect(report.first[2].size).to eq 1
  end

  it 'assumes that occupants with no dates are former occupants' do
    Occupant.create(
      unit: occupied_unit,
      name: 'Wan',
      move_in_date: nil,
      move_out_date: nil
    )

    expect(report.first[2].size).to eq 1
  end

  it 'includes move in dates of occupants' do
    expect(report.first[2][0][:move_in_date]).to eq Date.parse('2019-11-01')
  end

  it 'includes move out dates' do
    expect(report.first[2][0][:move_out_date]).to eq Date.parse('2020-01-31')
    expect(report[1][2][0][:move_out_date]).to be_nil
  end

  it 'shows future residents for currently occupied units' do
     Occupant.create(
      unit: occupied_unit,
      name: 'Korra',
      move_in_date: Date.parse('2021-11-01'),
      move_out_date: Date.parse('2024-01-31'),
    )

    expect(report[0][2].size).to eq 2
  end

  it 'provides key statistics' do
    # 2 currently occupied units total
    Unit.create!(
      number: 3,
      floorplan: 'Fire Nation Royal Palace',
      occupants: [
        Occupant.new(
          name: "Fire Lord Ozai",
          move_in_date: "2000-01-01",
          move_out_date: "2021-01-01",
        ),
      ]
    )
    # 1 future leased unit but nobody currently there
    # 4 vacant units including above
    Unit.create!(
      number: 4,
      floorplan: 'Southern Air Temple',
    )
    Unit.create!(
      number: 5,
      floorplan: 'Northern Air Temple',
    )
    Unit.create!(
      number: 6,
      floorplan: "Serpent's Pass",
    )
    Unit.create!(
      number: 7,
      floorplan: "Air Nomad Caves",

    )

    expect(rent_roll.key_statistics[:number_leased_units]).to eq 3
    expect(rent_roll.key_statistics[:number_vacant_units]).to eq 5
    expect(rent_roll.key_statistics[:number_occupied_units]).to eq 2
  end
end
