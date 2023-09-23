class Aggregator < ApplicationRecord

  belongs_to :visualization
  belongs_to :csv_header

  scope :x_axis, -> { where(:axis => 'xAxis') }
  scope :y_axis, -> { where(:axis => 'yAxis') }

end
