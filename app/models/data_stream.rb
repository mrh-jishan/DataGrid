class DataStream < ApplicationRecord
  include Tagify

  belongs_to :user
  has_many :data_stream_files, :dependent => :destroy

  validates :label, :presence => true

  def to_s
    label
  end

end
