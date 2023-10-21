class DataStream < ApplicationRecord

  belongs_to :user
  has_many :data_stream_files

  validates :label, :presence => true

  def to_s
    label
  end

end
