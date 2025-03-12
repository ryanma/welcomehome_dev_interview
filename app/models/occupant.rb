class Occupant < ActiveRecord::Base
  belongs_to :unit

  validates :name, presence: true
end
