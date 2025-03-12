require "rails_helper"

# A rent roll report
# [X] - lists units in order by unit number, and includes the
# following data:
#
# - [x] Unit number
# - [x] Floor Plan name
# - [x] Resident name
# - [] Resident status (current or future)
# - [] Move in date
# - [] Move out date
#
# A rent roll is run for a given date. It includes current and future
# residents, as well as vacant units.
#
# This rent roll report will be viewed in the rails console, it can be an array of
# arrays or a formatted string.

RSpec.describe RentRollReport do
  let(:date) { Date.parse "2020-01-01" }
  let!(:unit_1) { Unit.create(number: 1, floorplan: "Bay View", occupant_name: "Aang") }
  let(:report) { RentRollReport.new(date).report }

  it 'is run for a given date' do
    expect(RentRollReport.new(date).date).to eq date
  end

  it 'lists units in order' do
    unit_2 = Unit.create(number: 2, floorplan: "Mountain View")

    expect(RentRollReport.new(Date.today).units).to eq [ unit_1, unit_2 ]
  end

  it 'includes unit data' do
    expect(report.first[0]).to eq 1
  end

  it 'includes floorplan data' do
    expect(report.first[1]).to eq "Bay View"
  end

  it 'provides an occupant name' do
    expect(report.first[2]).to eq "Aang"
  end
end
