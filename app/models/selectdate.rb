class Selectdate < ActiveRecord::Base
  belongs_to :attendee
  belongs_to :task
  has_many :responses
end
