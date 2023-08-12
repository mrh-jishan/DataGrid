module DashboardsHelper
  def data_type_pill(data_type)
    case data_type
    when :string # Matches integers
      :count
    when :integer # Matches decimals/floats
      :sum
    when :float# Matches dates in yyyy-mm-dd format
      :sum
    when :date
      :count
    else
      :count # Default to string data type if the type cannot be determined
    end
  end
end
