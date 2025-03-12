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
#
# A rent roll is run for a given date. It includes current and future
# residents, as well as vacant units.
#
# This rent roll report will be viewed in the rails console, it can be an array of
# arrays or a formatted string.

RSpec.describe RentRollReport do
  let(:date) { Date.parse '2020-01-01' }
  let!(:unit_1) do
    Unit.create(number: 1,
                floorplan: 'Kiyoshi Island',
                occupant_name: 'Aang',
                move_in_date: Date.parse('2019-11-01'),
                move_out_date: Date.parse('2020-01-31'),)
  end
  let!(:unit_2) do
    Unit.create(number: 2,
                floorplan: 'Chin Village',
                occupant_name: 'Katara',
                move_in_date: '2020-03-01',)
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

  it 'provides an occupant name' do
    expect(report.first[2]).to eq 'Aang'
  end

  it 'indicates if this is a future or current resident' do
    expect(report.first[3]).to eq 'current'
    expect(report[1][3]).to eq 'future'
  end

  it 'includes move in dates' do
    expect(report.first[4]).to eq Date.parse('2019-11-01')
  end

  it 'includes move out dates' do
    expect(report.first[5]).to eq Date.parse('2020-01-31')
    expect(report[1][5]).to be_nil
  end
end
