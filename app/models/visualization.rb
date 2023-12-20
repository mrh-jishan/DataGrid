class Visualization < ApplicationRecord

  belongs_to :dataset
  has_many :csv_headers, :through => :dataset
  has_many :aggregators, :dependent => :destroy
  has_and_belongs_to_many :dashboards

  validates :label, :chart_type, :presence => true

  CHART_TYPES = { bar: 'Bar Chart', line: 'Line Chart', pie: 'Pie Chart', doughnut: 'Doughnut Chart' , radar: 'Radar Chart' }

  def patch_aggregators(column_names, group_by)
    upsert_data = aggregate_headers(column_names, group_by, self.id)
    unless upsert_data.blank?
      self.aggregators.upsert_all(upsert_data, :unique_by => [:visualization_id, :csv_header_id, :aggregator_function, :axis])
    end
  end

  def x_axis_object
    aggregators.includes([:csv_header]).x_axis.each_with_object({}) { |agg, hash| hash[agg.csv_header.name] = agg.aggregator_function }
  end

  def y_axis_object
    aggregators.includes([:csv_header]).y_axis.each_with_object({}) { |agg, hash| hash[agg.csv_header.name] = agg.aggregator_function }
  end

  protected

  def aggregate_headers(column_names, group_by, visualization_id)
    x_axis_headers = map_headers(column_names, visualization_id, 'xAxis')
    y_axis_headers = map_headers(group_by, visualization_id, 'yAxis')
    x_axis_headers + y_axis_headers
  end

  def map_headers(header_mapping, visualization_id, axis)
    CsvHeader.where(name: header_mapping.keys)
             .map do |csv_header|
      {
        visualization_id: visualization_id,
        csv_header_id: csv_header.id,
        aggregator_function: header_mapping[csv_header.name],
        axis: axis
      }
    end
  end

  def to_s
    label
  end

end
