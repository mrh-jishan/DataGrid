module DashboardsHelper
  def data_type_pill(data_type)
    case data_type.to_sym
    when :string, :date # Matches integers
      :count
    when :integer, :float # Matches decimals/floats
      :sum
    else
      :count # Default to string data type if the type cannot be determined
    end
  end
end
