class DataStream < ApplicationRecord
  belongs_to :user
  belongs_to :dataset
  has_many :data_stream_files, :dependent => :destroy

  def to_s
    dataset.to_s
  end

end
