class User < ActiveRecord::Base
  has_many :car_selections

  accepts_nested_attributes_for :car_selections, allow_destroy: true

  validates :name, presence: true

  def car_makers
    car_selections.map(&:maker)
  end
end
