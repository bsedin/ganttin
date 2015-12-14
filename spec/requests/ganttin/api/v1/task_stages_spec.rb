require 'rails_helper'

module Ganttin
  module API
    describe V1::TaskStages do
      before do
        @task = create(:task)
        @current_user.tasks << @task
      end

      context "GET /api/tasks/:task_id/stages" do
        it 'should return an array of stages' do
          task_stage = create(:task_stage, task_id: @task.id)
          get "/api/tasks/#{@task.id}/stages"
          expect(last_response.status).to eq 200
          expect(last_response.body).to have_json_size(1)
          expect(last_response.body).to be_json_eql(task_stage.id.to_json).at_path('0/task_stage/id')
        end
      end

      context "GET /api/tasks/:task_id/stages/:id" do
        it 'should return a stage by id' do
          task_stage = create(:task_stage, task_id: @task.id)
          get "/api/tasks/#{@task.id}/stages/#{task_stage.id}"
          expect(last_response.status).to eq 200
          expect(last_response.body).to have_json_path 'task_stage/id'
          expect(last_response.body).to be_json_eql(task_stage.id.to_json).at_path('task_stage/id')
          expect(last_response.body).to be_json_eql(@task.id.to_json).at_path('task_stage/task_id')
        end

        it 'should return a 404 on missing stage' do
          get "/api/tasks/#{@task.id}/stages/0"
          expect(last_response.status).to eq 404
        end
      end

      context "POST /api/tasks/:task_id/stages" do
        it 'should create stage' do
          task_stage = build(:task_stage, task_id: @task.id)
          expect do
            post "/api/tasks/#{@task.id}/stages", { task_stage: task_stage.attributes }
          end.to change(Ganttin::TaskStage, :count).by(1)
          expect(last_response.status).to eq 201
          expect(last_response.body).to have_json_path 'task_stage/id'
          expect(last_response.body).to be_json_eql(@task.id.to_json).at_path('task_stage/task_id')
        end
      end

      context "PUT /api/tasks/:task_id/stages/:id" do
        it 'should update stage' do
          task_stage = create(:task_stage, task_id: @task.id)
          task_stage.title = Faker::Lorem.sentence
          put "/api/tasks/#{@task.id}/stages/#{task_stage.id}", { task_stage: task_stage.attributes }
          expect(last_response.status).to eq 200
          expect(last_response.body).to have_json_path 'task_stage/id'
          expect(last_response.body).to be_json_eql(task_stage.title.to_json).at_path('task_stage/title')
        end
      end

      context "DELETE /api/tasks/:task_id/stages/:id" do
        it 'should delete stage and returns a 204 status code' do
          task_stage = create(:task_stage, task_id: @task.id)
          expect do
            delete "/api/tasks/#{@task.id}/stages/#{task_stage.id}"
          end.to change(Ganttin::TaskStage, :count).by(-1)
          expect(last_response.status).to eq 204
        end
      end
    end
  end
end
