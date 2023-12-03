class CsvHeader < ApplicationRecord

  default_scope { order(name: :asc) }

  belongs_to :dataset
  has_many :aggregators, :dependent => :destroy

  scope :x_axi_headers, -> { includes([:aggregators])
                               .where(aggregators: { axis: 'xAxis' }) }
  scope :y_axi_headers, -> { includes([:aggregators])
                               .where(aggregators: { axis: 'yAxis' }) }

  def to_s
    name.parameterize.underscore
  end

end
