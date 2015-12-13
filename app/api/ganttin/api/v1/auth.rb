module Ganttin
  module API
    class V1::Auth < ::Grape::API
      resource :auth do

        desc 'Sign up'
        params do
          requires :password, type: String
          requires :password_confirmation, type: String
          optional :email, type: String, allow_blank: false, regexp: /.+@.+/
        end
        post '/sign_up' do
          error! 'Already authorized', 400 if authenticated?
          @current_user = ::Ganttin::User.create(permitted_params[:user])
          render rabl: 'v1/auth/user', status: 201
        end

        desc 'Log in'
        params do
          optional :id, type: String
          optional :email, type: String, allow_blank: false, regexp: /.+@.+/
          exactly_one_of :email, :id
          requires :password, type: String
          optional :remember_me, type: Boolean, default: false
        end
        post '/log_in', rabl: 'v1/auth/user' do
          if authenticated?
            current_user.reset_authentication_token!
            current_user.forget_me!
            @current_user = nil
          end
          status 200
          user = ::Ganttin::User
          user =
            if permitted_params[:id]
              user.where(id: permitted_params[:id]).first
            elsif permitted_params[:email]
              user.where(email: permitted_params[:email]).first
            end

          if user && user.valid_password?(permitted_params[:password])
            @current_user = user
            current_user.reset_authentication_token!
            if permitted_params[:remember_me]
              current_user.remember_me!
            end
          else
            unauthorized!
          end
        end

        desc 'Log out'
        before do
          authenticate!
        end
        delete '/log_out' do
          current_user.reset_authentication_token!
          current_user.forget_me!
          body false
        end
      end
    end
  end
end
