class Visualization < ApplicationRecord

  belongs_to :file_upload
  has_many :aggregators

  def patch_aggregators(column_names, group_by)
    puts "column_names------------------#{column_names}"
    puts "group_by------------------#{group_by}"
    puts "self_id------------------#{self.id}"
    puts "aggregators------------------#{self.aggregators}"

    x_axis =  patch_aggregator(column_names)
    y_axis = patch_aggregator(group_by)
    # self.aggregators.upsert_all({}, :unique_by => [:visualization_id, :csv_header_id, :aggregator_function, :axis])
  end

  protected

  def patch_aggregator(column_names)
    column_names.reduce([]) do |column_name, aggregate_function|

    end
  end

end
