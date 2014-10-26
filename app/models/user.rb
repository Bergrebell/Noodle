class User < ActiveRecord::Base
  #mit attendees ist am ehesten "teilnahmen" gemeint
    has_many :attendees
    has_many :tasks, :through => :attendees


    attr_accessor :password
    EMAIL_REGEX = %r{\A.+@.+\z}xi
    validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
    validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
    validates :password, :confirmation => true
    validates_length_of :password, :in => 6..20, :on => :create

    before_save :encrypt_password
    after_save :clear_password

    def encrypt_password
        if password.present?
            self.salt= Digest::SHA1.hexdigest("# We add {email} as unique value and #{Time.now} as random value")
            self.encrypted_password= Digest::SHA1.hexdigest("Adding #{salt} to {password}")
        end
    end

    def clear_password
        self.password = nil
    end

    def self.authenticate(username_or_email="", login_password="")
        if  EMAIL_REGEX.match(username_or_email)    
            user = User.find_by_email(username_or_email)
        else
            user = User.find_by_username(username_or_email)
        end
        if user && user.match_password(login_password)
            return user
        else
            return false
        end
    end   

    def match_password(login_password="")
        encrypted_password == Digest::SHA1.hexdigest("Adding #{salt} to {login_password}")
    end
end
