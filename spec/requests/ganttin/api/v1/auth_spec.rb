require 'rails_helper'

module Ganttin
  module API
    describe V1::Auth do
      context 'POST /api/auth/sign_up' do
        it 'should create new user', authenticate: false do
          users_count = ::Ganttin::User.count
          post '/api/auth/sign_up', { password: 'password', password_confirmation: 'password' }
          expect(last_response.status).to eq 201
          expect(last_response.body).to have_json_path 'user/id'
          expect(last_response.body).to have_json_path 'user/access_token'
          expect(::Ganttin::User.count).to eq(users_count+1)
        end

        it 'should not create new user if authenticated' do
          users_count = ::Ganttin::User.count
          post '/api/auth/sign_up', { password: 'password', password_confirmation: 'password' }
          expect(last_response.status).to eq 400
          expect(last_response.body).not_to have_json_path 'user/id'
          expect(last_response.body).not_to have_json_path 'user/access_token'
          expect(::Ganttin::User.count).to eq(users_count)
        end
      end

      context 'POST /api/auth/log_in' do
        it 'should login as user by id', authenticate: false  do
          user = create(:user,
                        password: 'password',
                        password_confirmation: 'password'
                       )
          post '/api/auth/log_in', { id: user.id, password: 'password' }
          expect(last_response.status).to eq 200
          expect(last_response.body).to have_json_path 'user/id'
          expect(last_response.body).to have_json_path 'user/access_token'
        end

        it 'should login as user by email', authenticate: false  do
          user = create(:user,
                        email: 'kr3ssh@gmail.com',
                        password: 'password',
                        password_confirmation: 'password'
                       )
          post '/api/auth/log_in', { email: user.email, password: 'password' }
          expect(last_response.status).to eq 200
          expect(last_response.body).to have_json_path 'user/id'
          expect(last_response.body).to have_json_path 'user/access_token'
        end

        it 'should fail to login with invalid password', authenticate: false  do
          user = create(:user)
          post '/api/auth/log_in', { id: user.id, password: 'invalid_password' }
          expect(last_response.status).to eq 401
        end

        it 'should remember me if I\'ll ask gently', authenticate: false  do
          user = create(:user, password: 'password', password_confirmation: 'password')
          post '/api/auth/log_in', { id: user.id, password: 'password', remember_me: true }
          expect(user.reload.remember_expired?).to eq false
        end

        it 'should logout before logging in' do
          old_access_token = @current_user.access_token
          user = create(:user, password: 'password', password_confirmation: 'password')
          post '/api/auth/log_in', { id: user.id, password: 'password' }
          expect(@current_user.reload.access_token).not_to eq(old_access_token)
          expect(last_response.body).to be_json_eql(user.id.to_json).at_path('user/id')
        end
      end

      context 'DELETE /api/auth/log_out' do
        it 'should respond with nothing' do
          delete '/api/auth/log_out'
          expect(last_response.status).to eq 204
        end

        it 'should reset access token' do
          access_token = @current_user.access_token
          delete '/api/auth/log_out'
          expect(@current_user.reload.access_token).not_to eq(access_token)
        end

        it 'should forget user' do
          delete '/api/auth/log_out'
          expect(@current_user.reload.remember_expired?).to eq true
        end
      end
    end
  end
end
