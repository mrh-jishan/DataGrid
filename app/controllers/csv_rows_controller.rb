class CsvRowsController < ApplicationController

  before_action :set_dataset, :only => [:index, :update]

  def index
    column_names = JSON.parse(URI.decode_www_form_component(params[:column_names].to_s))
    group_by = JSON.parse(URI.decode_www_form_component(params[:group_by].to_s))
    @rows = @dataset.csv_rows.select_columns(column_names).group_by_column_names(group_by)
  end

  def update
    @csv_row = @dataset.csv_rows.find(params[:id])
    respond_to do |format|
      if @csv_row.update(dataset_params)
        format.json { render json: { success: true } }
      else
        format.json { render json: { success: false, errors: @dataset.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  protected

  def set_dataset
    @dataset = current_user.datasets.find(params[:dataset_id])
  end

end
