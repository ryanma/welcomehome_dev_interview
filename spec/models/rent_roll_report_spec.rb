require 'rails_helper'

# A rent roll report
# [X] - lists units in order by unit number, and includes the
# following data:
#
# - [x] Unit number
# - [x] Floor Plan name
# - [x] Resident name
# - [x] Resident status (current or future)
# - [x] Move in date
# - [x] Move out date
# - [] future residents for currently occupied unit
#
# A rent roll is run for a given date. It includes current and future
# residents, as well as vacant units.
#
# This rent roll report will be viewed in the rails console, it can be an array of
# arrays or a formatted string.

RSpec.describe RentRollReport do
  let(:date) { Date.parse '2020-01-01' }
  let!(:unit_1) do
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
  let!(:unit_2) do
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
  let(:report) { RentRollReport.new(date).report }

  it 'is run for a given date' do
    expect(RentRollReport.new(date).date).to eq date
  end

  it 'lists units in order' do
    expect(RentRollReport.new(Date.today).units).to eq [ unit_1, unit_2 ]
  end

  it 'includes unit data' do
    expect(report.first[0]).to eq 1
  end

  it 'includes floorplan data' do
    expect(report.first[1]).to eq 'Kiyoshi Island'
  end

  fit 'provides the names of occupants' do
    expect(report.first[2][0][:name]).to eq 'Aang'
  end

  it 'provides status of residents' do
    expect(report.first[2][0][:status]).to eq 'current'
    expect(report[1][2][0][:status]).to eq 'future'
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
      unit: unit_1,
      name: 'Korra',
      move_in_date: Date.parse('2021-11-01'),
      move_out_date: Date.parse('2024-01-31'),
    )

    expect(report[0][2].size).to eq 2
  end
end
