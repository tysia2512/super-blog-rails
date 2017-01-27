class User < ApplicationRecord
  require 'bcrypt'
  attr_accessor :password
  validates :name, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :password, :confirmation => true #password_confirmation attr
  validates_length_of :password, :in => 6..20#, :on => :create
  before_save :encrypt_password
  after_save :clear_password

  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      print "SALT\n"
      print salt
      print "\n\n"
      self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
    end
  end

  def clear_password
    self.password = nil
  end

  def admin
    if self.name == "tysia2512"
    then true
    else false
    end
  end

  def authenticate (passwd)
    print self.salt
    encrypted = BCrypt::Engine.hash_secret(passwd, self.salt)
    if encrypted == self.encrypted_password
    then true
    else false
    end
  end

  def new
    @user = User.new 
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "You signed up successfully"
      flash[:color]= "valid"
    else
      flash[:notice] = "Form is invalid"
      flash[:color]= "invalid"
    end
    render "new"
  end

  def edit
  end
end
