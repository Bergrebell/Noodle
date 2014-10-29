class Testuser < ActiveRecord::Base
  has_many :attendees
  has_many :tasks, :through => :attendees
end
