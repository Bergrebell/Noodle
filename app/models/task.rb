class Task < ActiveRecord::Base
  has_many :attendees
  has_many :users, :through => :attendees
  has_many :selectdates, dependent: :destroy
  has_many :attachments
  has_many :comments



  validates :title, presence: true,
            length: { minimum: 1 },
            length: { maximum: 18 }

  validates :text, presence: true,
            length: { minimum: 1 }

end
