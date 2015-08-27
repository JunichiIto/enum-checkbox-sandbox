class CarSelection < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :maker, presence:true, uniqueness: { scope: :user_id }

  enum maker: %i(toyota nissan honda)
end
