class Aggregator < ApplicationRecord

  belongs_to :visualization
  belongs_to :csv_header

end
