class User < ActiveRecord::Base
  has_many :car_selections

  def car_makers
    car_selections.map(&:maker)
  end
end
