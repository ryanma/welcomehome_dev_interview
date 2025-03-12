class Unit < ActiveRecord::Base
  validates :number, presence: true, uniqueness: true
  validates :floorplan, presence: true

  def vacant?
    !occupant_name
  end
end
