class DataStream < ApplicationRecord
  include Tagify

  belongs_to :user
  belongs_to :dataset, :optional => true
  has_many :data_stream_files, :dependent => :destroy

  validates :label, :presence => true

  def to_s
    label
  end

end
