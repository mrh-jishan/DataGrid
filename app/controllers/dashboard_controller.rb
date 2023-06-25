class DashboardController < ApplicationController
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
        yAxes: [{
                  ticks: {
                    beginAtZero: true
                  }
                }]
      }
    }

    @choices_data = [{
                       value: 'Value 1',
                       label: 'Label 1',
                       id: 1
                     },
                     {
                       value: 'Value 2',
                       label: 'Label 2',
                       id: 2,
                       # customProperties: {
                       #   random: 'I am a custom property'
                       # }
                     }]

  end
end
