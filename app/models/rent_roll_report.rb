class RentRollReport
  attr :date

  def initialize(date)
    @date = date
  end

  def units
    Unit.all.order(:number)
  end

  def report
    units.map do |unit|
      [ unit.number, unit.floorplan, unit.resident_name ]
    end
  end
end
