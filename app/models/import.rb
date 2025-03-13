require "csv"

class Import
  def process
    csv_data = File.read("assets/units-and-residents.csv")
    lines = CSV.parse(csv_data, headers: true, converters: :integer)

    lines.each do |line|
      unit = Unit.create_with(floorplan: line["floor_plan"]).find_or_create_by!(number: line["unit"])

      if line["resident"]
        Occupant.create!(
          unit: unit,
          name: line["resident"],
          move_in_date: line["move_in"] ? Date.strptime(line["move_in"], "%m/%d/%Y") : nil,
          move_out_date: line["move_out"] ? Date.strptime(line["move_out"], "%m/%d/%Y") : nil,
        )
      end
    end
  end
end
