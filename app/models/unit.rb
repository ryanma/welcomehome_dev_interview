class Unit < ActiveRecord::Base
  has_many :occupants

  validates :number, presence: true, uniqueness: true
  validates :floorplan, presence: true

  scope :occupied, ->(date) {
    joins(:occupants).where(occupants: { move_in_date: ..date, move_out_date: date.. }).or(Unit.where(occupants: { move_in_date: ..date, move_out_date: nil }))
  }

  def vacant?(date = Date.today)
    !occupants.where(move_in_date: ..date).and(Occupant.where(unit: self, move_out_date: date...)).any?
  end
end
