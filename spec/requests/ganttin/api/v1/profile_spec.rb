require 'rails_helper'

module Ganttin
  module API
    describe V1::Profile do
      context 'GET /api/profile' do
        it 'should return profile info' do
          get '/api/profile'
          expect(last_response.status).to eq(200)
          expect(last_response.body).to be_json_eql(@current_user.id.to_json).at_path('user/id')
        end
      end

      #context 'PUT /api/profile' do
        #it 'should update profile and return profule attributes' do
          #put '/api/profile', { user: {}}
          #expect(last_response.status).to eq(200)
          #expect(last_response.body).to be_json_eql(age.to_json).at_path('user/age')
        #end
      #end
    end
  end
end
