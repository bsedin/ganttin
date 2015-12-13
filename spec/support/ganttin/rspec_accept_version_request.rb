module Ganttin
  module RSpecAcceptVersionRequest
    extend ActiveSupport::Concern

    included do
      before do
        header 'ACCEPT_VERSION', 'v1'
      end
    end
  end
end
