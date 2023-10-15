class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable, :lockable, :trackable

  has_many :user_roles
  has_many :roles, through: :user_roles

  has_many :file_uploads
  has_many :visualizations, :through => :file_uploads
  has_many :dashboards
  has_many :data_platforms
  has_many :platforms, :through => :data_platforms

  def admin?
    roles.where(name: 'admin').exists?
  end

  def moderator?
    roles.where(name: 'moderator').exists?
  end

  def to_s
    Mail::Address.new(email).local.titleize
  end
end
