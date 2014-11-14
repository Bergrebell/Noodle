class Selectdate < ActiveRecord::Base
  belongs_to :attendee
  belongs_to :task
end
