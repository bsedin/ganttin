module Ganttin
  module RSpecAPIAuthRequest
    extend ActiveSupport::Concern

    included do
      before do |example|
        unless example.metadata[:authenticate] == false
          @current_user = create(:user)
          header 'X-User-Id', @current_user.id
          header 'X-User-Access-Token', @current_user.access_token
        end
      end
    end
  end
end
