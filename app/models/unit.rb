class Unit < ActiveRecord::Base
  validates :number, presence: true, uniqueness: true
  validates :floorplan, presence: true

  has_one :occupancy

  def resident_name
    "Resident Name"
  end
end
