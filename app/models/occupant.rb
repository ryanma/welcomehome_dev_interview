class Occupant < ActiveRecord::Base
  belongs_to :unit

  validates :name, presence: true

  scope :current_and_future, ->(unit, date) {
    where(unit: unit, move_in_date: ..date, move_out_date: date..).or(Occupant.where(unit: unit, move_in_date: date..))
  }
end
