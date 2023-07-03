class HomeController < ApplicationController
  def index
    @choices_data = [{
                       value: 'Value 1',
                       label: 'Label 1',
                       id: 1
                     },
                     {
                       value: 'Value 2',
                       label: 'Label 2',
                       id: 2,
                     }]
  end

end
