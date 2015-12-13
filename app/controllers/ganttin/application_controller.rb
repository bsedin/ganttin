module Ganttin
  class ApplicationController < ActionController::Base
    def not_found
      render text: 'Not found', status: 404
    end
  end
end
