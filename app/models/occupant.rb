class Occupant < ActiveRecord::Base
  belongs_to :unit

  validates :name, presence: true
  validate :no_overlap_with_other_occupants

  private

  def no_overlap_with_other_occupants
    if Occupant.where(unit: unit, move_out_date: move_in_date..).any?
      errors.add(:move_in_date, "can't overlap with another occupant")
    end

    if Occupant.where(unit: unit, move_in_date: ..move_out_date).any?
      errors.add(:move_out_date, "can't overlap with another occupant")
    end
  end
end
