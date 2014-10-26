class Task < ActiveRecord::Base
  has_many :attendees
  has_many :users, :through => :attendees



  validates :title, presence: true,
            length: { minimum: 5 }

  validates :text, presence: true,
            length: { minimum: 10 }

end
