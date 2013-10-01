class Task < ActiveRecord::Base
  attr_accessible :complete, :name

  validates :name, presence: true
end
