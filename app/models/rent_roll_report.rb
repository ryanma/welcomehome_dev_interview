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
      [
        unit.number,
        unit.floorplan,
        unit.occupants.map do |occ|
          status = occ.move_in_date <= date ? "current" : "future"
          {
            name: occ.name,
            status: status,
            move_in_date: occ.move_in_date,
            move_out_date: occ.move_out_date,
          }
        end,
      ]
    end
  end
end
