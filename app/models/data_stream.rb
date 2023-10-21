class DataStream < ApplicationRecord

  belongs_to :user
  has_many :data_stream_files

  validates :label, :presence => true

  # has_many :access_tokens, class_name: 'Doorkeeper::AccessToken', as: :resource_owner, dependent: :destroy
  # before_create :generate_authentication_token


  private

  def generate_authentication_token
    self.token = SecureRandom.hex(20)
  end

end
