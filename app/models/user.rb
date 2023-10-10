class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable, :lockable, :trackable

  has_many :file_uploads
  has_many :visualizations, :through => :file_uploads
  has_many :dashboards

  def to_s
    Mail::Address.new(email).local.titleize
  end
end
