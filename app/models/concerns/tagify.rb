module Tagify
  extend ActiveSupport::Concern

  included do

    def tagify
      unique_by.join(", ")
    end

  end

end