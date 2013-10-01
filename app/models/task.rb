class Task < ActiveRecord::Base
  attr_accessible :complete, :name, :user_id

  validates :name, presence: true

  belongs_to :user

  scope :complete, where(complete: true)
  scope :uncomplete, where(complete: false)
  scope :by, lambda { |id| where(user_id: id) }

end
