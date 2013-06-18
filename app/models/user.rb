class User < ActiveRecord::Base
  validates :name,     presence: true,
                       uniqueness: true,
  validates :email,    presence: true,
                       uniqueness: true,
                       format: { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :password_hash, presence: true

  def password
    @password ||= Bcrypt::Password.new(password_hash)
  end

  def password=(pass)
    @password = Bcrypt::Password.create(pass)
    self.password_hash = @password
  end

  def self.create(params={})
    @user = User.new(params)
    @user.password = params[:password]
    @user.save!
    @user
  end

  def self.authenticate(params)
    user = User.find_by_name(params[:name])
    (user && user.password == params[:password]) ? user : nil
  end

end