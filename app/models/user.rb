class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable, :lockable, :trackable, :uid

  has_many :user_roles
  has_many :roles, through: :user_roles

  has_many :datasets
  has_many :visualizations, :through => :datasets
  has_many :dashboards
  has_many :data_platforms
  has_many :platforms, :through => :data_platforms

  has_many :data_streams

  def admin?
    roles.where(name: 'admin').exists?
  end

  def moderator?
    roles.where(name: 'moderator').exists?
  end

  def api_token?
    self.api_token.present?
  end

  def generate_api_token
    self.api_token = Digest::SHA1.hexdigest([Time.now, rand(111..999)].join)
  end

  def to_roles
    roles.pluck(:name)
  end

  def to_s
    Mail::Address.new(email).local.titleize
  end
end
