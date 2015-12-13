module Ganttin
  module API
    class V1::Profile < ::Grape::API
      resource :profile do
        before do
          authenticate!
        end

        desc 'Get profile data'
        get '/', rabl: 'v1/profile/user' do
        end

        desc 'Update profile info'
        params do
          requires :user, type: Hash do
            #optional :age, type: Integer
            #optional :email, type: String, allow_blank: false, regexp: /.+@.+/
            # TODO:
            #optional :old_password, type: String
            #optional :password, type: String
            #optional :password_confirmation, type: String
          end
        end
        put '/', rabl: 'v1/profile/user' do
          current_user.update(permitted_params[:user])
        end

        desc 'Delete user account'
        delete '/' do
          if current_user.destroy
            body false
          else
            render rabl: 'v1/profile/user'
          end
        end
      end
    end
  end
end
