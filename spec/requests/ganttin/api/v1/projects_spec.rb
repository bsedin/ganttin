require 'rails_helper'

module Ganttin
  module API
    describe V1::Projects do
      context 'GET /api/projects' do
        it 'should return an array of projects' do
          project = create(:project)
          @current_user.projects << project
          get '/api/projects'
          expect(last_response.status).to eq 200
          expect(last_response.body).to have_json_size(1)
          expect(last_response.body).to be_json_eql(project.id.to_json).at_path('0/project/id')
        end
      end

      context 'GET /api/projects/:id' do
        it 'should return a project by id' do
          project = create(:project)
          @current_user.projects << project
          get "/api/projects/#{project.id}"
          expect(last_response.status).to eq 200
          expect(last_response.body).to have_json_path 'project/id'
          expect(last_response.body).to be_json_eql(project.id.to_json).at_path('project/id')
          expect(last_response.body).to be_json_eql(@current_user.id.to_json).at_path('project/member_ids/0')
        end

        it 'should return a 404 on missing project' do
          get "/api/projects/0"
          expect(last_response.status).to eq 404
        end
      end

      context 'POST /api/projects' do
        it 'should create project' do
          project = build(:project)
          expect do
            post "/api/projects", { project: project.attributes }
          end.to change(Ganttin::Project, :count).by(1)
          expect(last_response.status).to eq 201
          expect(last_response.body).to have_json_path 'project/id'
          expect(last_response.body).to be_json_eql(@current_user.id.to_json).at_path('project/member_ids/0')
        end
      end

      context 'PUT /api/projects/:id' do
        it 'should update project' do
          project = create(:project)
          @current_user.projects << project
          project.title = Faker::Lorem.sentence
          put "/api/projects/#{project.id}", { project: project.attributes }
          expect(last_response.status).to eq 200
          expect(last_response.body).to have_json_path 'project/id'
          expect(last_response.body).to be_json_eql(project.title.to_json).at_path('project/title')
        end
      end

      context 'DELETE /api/projects/:id' do
        it 'should delete project and returns a 204 status code' do
          project = create(:project)
          @current_user.projects << project
          expect do
            delete "/api/projects/#{project.id}"
          end.to change(Ganttin::Project, :count).by(-1)
          expect(last_response.status).to eq 204
        end
      end
    end
  end
end
