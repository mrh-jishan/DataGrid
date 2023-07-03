class DashboardsController < ApplicationController

  before_action :set_file_upload, :only => [:index]

  def index

    @chart_data = {
      labels: %w[January February March April May June July AUG],
      datasets: [{
                   label: 'My First dataset',
                   backgroundColor: 'transparent',
                   borderColor: '#3B82F6',
                   data: [37, 83, 78, 54, 12, 5, 99, 100]
                 },
                 {
                   label: 'My Another dataset',
                   backgroundColor: 'transparent',
                   borderColor: '#3B82F6',
                   data: [1, 2, 78, 54, 5, 5, 99, 10]
                 }]
    }

    @chart_options = {
      scales: {
        #   yAxes: [{
        #             ticks: {
        #               beginAtZero: true
        #             }
        #           }]
      }
    }

    @headers = @file_upload.csv_headers
    @rows = @file_upload.csv_rows
  end

  def set_file_upload
    @file_upload = FileUpload.find(params[:file_upload_id])
  end

end
