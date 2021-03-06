class User < ActiveRecord::Base
  has_many :attendees, dependent: :destroy
  has_many :tasks, :through => :attendees
  
  has_many :friendships
  has_many :friends, :through => :friendships

  has_many :responses

  attr_accessor :password
  before_save :encrypt_password
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates_presence_of :username
  validates_uniqueness_of :username

  #check user authentification
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  #encrypt the password
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  #search for user in user model
  def self.search(search)
    if search
      where('username LIKE ?', "%#{search}%")
    else
      find(:all)
    end
  end
end
