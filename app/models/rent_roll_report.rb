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
        Occupant.current_and_future(unit, date).map do |occ|
          if occ.move_in_date && occ.move_in_date <= date
            status = "current"
          else
            status = "future"
          end

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

  def key_statistics
    occupied_ids = Unit.occupied(date).pluck(:id)

    {
      number_leased_units: Unit.where.associated(:occupants).count,
      number_occupied_units: occupied_ids.count,
      number_vacant_units: Unit.where("id not in (?)", occupied_ids).count,
    }
  end
end
