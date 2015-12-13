module Ganttin
  module RSpecJsonRequest
    extend ActiveSupport::Concern

    included do
      before do
        request.env['HTTP_ACCEPT'] = 'application/json'
      end
    end
  end
end
