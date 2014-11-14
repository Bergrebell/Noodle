class Attendee < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
  has_many :selectdates
end
