class Task < ActiveRecord::Base
  has_many :attendees
  has_many :users, :through => :attendees
  has_many :selectdates, dependent: :destroy
  has_many :attachments



  validates :title, presence: true,
            length: { minimum: 1 }

  validates :text, presence: true,
            length: { minimum: 1 }

end
