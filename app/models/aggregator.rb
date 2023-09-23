class Aggregator < ApplicationRecord

  belongs_to :visualization
  belongs_to :csv_header

  scope :x_axis, -> { where(:axis => 'xAxis') }
  scope :y_axis, -> { where(:axis => 'yAxis') }

  # scope :x_axis_csv_headers, -> { where(:axis => 'xAxis').includes(:csv_header) }
  # scope :y_axis_csv_headers, -> { where(:axis => 'yAxis').includes(:csv_header) }

end
