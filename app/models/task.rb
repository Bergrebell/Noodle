class Task < ActiveRecord::Base
  has_many :attendees
  has_many :users, :through => :attendees



  validates :title, presence: true,
            length: { minimum: 1 }

  validates :text, presence: true,
            length: { minimum: 1 }

end
