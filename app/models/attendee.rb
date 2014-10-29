class Attendee < ActiveRecord::Base
  belongs_to :task
  belongs_to :testuser
end
