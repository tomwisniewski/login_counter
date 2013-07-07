require 'data_mapper'
require 'bcrypt'
require 'debugger'

class User
  include BCrypt
  include DataMapper::Resource

  property :id, Serial
  property :first_name, String,   :required => true, 
                                  :messages => {
                                    :presence => "Please provide us with your first name"
                                  }
  property :last_name, String,    :required => true, 
                                  :messages => {
                                    :presence => "Please provide us with your last name"
                                  }  
  property :email, String,        :required => true, 
                                  :unique => true, 
                                  :format => :email_address,
                                  :messages => {
                                    :presence  => "Please provide us with your email address",
                                    :is_unique => "We already have that email address in our system",
                                    :format    => "Please enter a valid email address"
                                  }
  property :login_count, Integer, :default => 0                            
  property :password_hash, Text,  :required => true, 
                                  :length => 60                            
  
  # validates_length_of :password, :within => 6..10
  validates_confirmation_of :password, :if => :new?

  def password
    @hashed_password ||= Password.new(password_hash)
  end

  def password=(unhashed_password)
    @hashed_password = Password.create(unhashed_password)
    self.password_hash = @hashed_password
  end

  def password_confirmation
    @password_confirmation
  end

  def password_confirmation=(unhashed_password_confirmation)
    @password_confirmation = unhashed_password_confirmation
  end  

  def update_login_count(updated_value) 
    self.update(:login_count => updated_value)
  end  

  def self.build(first, last, email, pass, pass_conf) 
    new_user = User.new
    new_user.first_name = first
    new_user.last_name = last
    new_user.email = email
    new_user.password = pass
    new_user.password_confirmation = pass_conf
    new_user
  end                         
end  