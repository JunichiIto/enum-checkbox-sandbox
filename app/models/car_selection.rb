class CarSelection < ActiveRecord::Base
  belongs_to :user
  enum maker: %i(toyota nissan honda vw benz bmw audi)
end
