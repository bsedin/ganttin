require 'rails_helper'

module Ganttin
  module API
    describe V1::Tasks do
      before do
        @project = create(:project)
        @current_user.projects << @project
      end

      context 'GET /api/tasks' do
        it 'should return an array of tasks' do
          task = create(:task, project_id: @project.id)
          @current_user.tasks << task
          get '/api/tasks'
          expect(last_response.status).to eq 200
          expect(last_response.body).to have_json_size(1)
          expect(last_response.body).to be_json_eql(task.id.to_json).at_path('0/task/id')
        end
      end

      context 'GET /api/tasks/:id' do
        it 'should return a task by id' do
          task = create(:task, project_id: @project.id)
          @current_user.tasks << task
          get "/api/tasks/#{task.id}"
          expect(last_response.status).to eq 200
          expect(last_response.body).to have_json_path 'task/id'
          expect(last_response.body).to be_json_eql(task.id.to_json).at_path('task/id')
          expect(last_response.body).to be_json_eql(@current_user.id.to_json).at_path('task/member_ids/0')
        end

        it 'should return a 404 on missing task' do
          get "/api/tasks/0"
          expect(last_response.status).to eq 404
        end
      end

      context 'POST /api/tasks' do
        it 'should create task' do
          task = build(:task, project_id: @project.id)
          expect do
            post "/api/tasks", { task: task.attributes }
          end.to change(Ganttin::Task, :count).by(1)
          expect(last_response.status).to eq 201
          expect(last_response.body).to have_json_path 'task/id'
          expect(last_response.body).to be_json_eql(@current_user.id.to_json).at_path('task/member_ids/0')
        end
      end

      context 'PUT /api/tasks/:id' do
        it 'should update task' do
          task = create(:task, project_id: @project.id)
          @current_user.tasks << task
          task.title = Faker::Lorem.sentence
          put "/api/tasks/#{task.id}", { task: task.attributes }
          expect(last_response.status).to eq 200
          expect(last_response.body).to have_json_path 'task/id'
          expect(last_response.body).to be_json_eql(task.title.to_json).at_path('task/title')
        end
      end

      context 'DELETE /api/tasks/:id' do
        it 'should delete task and returns a 204 status code' do
          task = create(:task, project_id: @project.id)
          @current_user.tasks << task
          expect do
            delete "/api/tasks/#{task.id}"
          end.to change(Ganttin::Task, :count).by(-1)
          expect(last_response.status).to eq 204
        end
      end
    end
  end
end
