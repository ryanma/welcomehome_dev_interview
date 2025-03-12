require "rails_helper"

# A rent roll report lists units in order by unit number, and includes the
# following data:
#
# - Unit number
# - Floor Plan name
# - Resident name
# - Resident status (current or future)
# - Move in date
# - Move out date
#
# A rent roll is run for a given date. It includes current and future
# residents, as well as vacant units.
#
# This rent roll report will be viewed in the rails console, it can be an array of
# arrays or a formatted string.

RSpec.describe RentRollReport do
  it 'is run for a given date' do
    date = Date.parse("2020-01-01")
    expect(RentRollReport.new(date).date).to eq date
  end

  it 'lists units in order' do
    unit_1 = Unit.create(number: 1)
    unit_2 = Unit.create(number: 2)

    expect(RentRollReport.new(Date.today).rooms).to be [ unit_1, unit_2 ]
  end
end
