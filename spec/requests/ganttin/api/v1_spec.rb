require 'rails_helper'

module Ganttin
  module API
    describe V1 do
      context 'GET status page', authenticate: false do
        it 'should return valid response using v1 version' do
          get '/api/status'
          expect(last_response.status).to eq(200)
        end

        it 'should return 404 using wrong version' do
          get '/api/status', {}, { 'HTTP_ACCEPT_VERSION' => 'v0'}
          expect(last_response.status).to eq(404)
        end

        it 'should return json response' do
          get '/api/status'
          expect(last_response.header['Content-Type']).to eq 'application/json'
        end

        it 'should return status' do
          get '/api/status'
          expect(last_response.body).to be_json_eql(%{"ok"}).at_path('status')
          expect(last_response.body).to have_json_path('date')
        end
      end
    end
  end
end
