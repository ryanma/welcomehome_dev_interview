class Unit < ActiveRecord::Base
  validates :number, presence: true, uniqueness: true
end
