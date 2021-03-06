class User < ActiveRecord::Base
  has_many :projects, :dependent => :destroy
  has_many :activities, :dependent => :nullify
  
  # new columns need to be added here to be writable through mass assignment
  attr_accessible :username, :email, :password, :password_confirmation, :openid_url
  
  attr_accessor :password
  before_save :prepare_password
  before_validation :add_protocol_to_openid_url
  
  validates_presence_of :username
  validates_uniqueness_of :username, :email, :openid_url, :allow_blank => true
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password, :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?
  validates_length_of :password, :minimum => 4, :allow_blank => true, :if => :password_required?
  
  # login can be either username or email address
  def self.authenticate(login, pass)
    user = find_by_username(login) || find_by_email(login)
    return user if user && user.matching_password?(pass)
  end
  
  def matching_password?(pass)
    self.password_hash == encrypt_password(pass)
  end
  
  def self.build_from_openid(openid)
    returning User.new do |user|
      user.username = openid['nickname']
      user.email = openid['email']
      user.openid_url = openid['openid_url']
    end
  end
  
  def self.find_by_openid_url(url)
    url = "http://#{url}" unless url.blank? || url.include?('://')
    super(url)
  end
  
  private
  
  def prepare_password
    unless password.blank?
      self.password_salt = Digest::SHA1.hexdigest([Time.now, rand].join)
      self.password_hash = encrypt_password(password)
    end
  end
  
  def encrypt_password(pass)
    Digest::SHA1.hexdigest([pass, password_salt].join)
  end
  
  def password_required?
    (password_hash.blank? && openid_url.blank?) || !password.blank?
  end
  
  def add_protocol_to_openid_url
    self.openid_url = "http://#{openid_url}" unless openid_url.blank? || openid_url.include?('://')
  end
end
