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
      if unit.occupant_name
        occupant_status = unit.move_in_date <= date ? "current" : "future"
      end

      [
        unit.number,
        unit.floorplan,
        unit.occupant_name,
        occupant_status,
        unit.move_in_date,
        unit.move_out_date,
      ]
    end
  end
end
