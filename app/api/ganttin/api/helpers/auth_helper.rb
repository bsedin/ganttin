module Ganttin
  module API
    module AuthHelper
      X_USER_ACCESS_TOKEN_HEADER = 'X-User-Access-Token'
      X_USER_ID_HEADER   = 'X-User-Id'

      def current_user
        @current_user || warden.user
      end

      def authenticate!
        unauthorized! unless authenticated?
      end

      def unauthorized!
        error! '401 Unauthorized', 401
      end

      def warden
        env['warden']
      end

      def authenticated?
        return true if warden.authenticated?

        id           = headers[X_USER_ID_HEADER]           || params[:user_id]
        access_token = headers[X_USER_ACCESS_TOKEN_HEADER] || params[:user_access_token]

        user = ::Ganttin::User.
          where(id: id, authentication_token: access_token).first

        return false if user.nil?

        if user.remember_created_at? && user.remember_expired?
          user.reset_authentication_token!
          user.forget_me!
          return false
        end

        @current_user = user
        true
      end
    end
  end
end
