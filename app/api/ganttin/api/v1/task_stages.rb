module Ganttin
  module API
    class V1::TaskStages < ::Grape::API
      before do
        authenticate!
      end

      params do
        requires :task_id, type: String, desc: 'Task id'
      end
      resource '/tasks/:task_id' do
        resource :stages do
          helpers do
            def task
              @task ||= current_user.tasks.where(id: params[:task_id]).first!
            end

            def resource
              @resource ||= task.stages.where(id: params[:id]).first!
            end

            def collection
              @collection ||= task.stages
            end

            alias_method :task_stages, :collection
            alias_method :task_stage, :resource
          end

          desc 'Get task_stages list'
          get '/', rabl: 'v1/task_stages/index' do
          end

          desc 'Get task_stage'
          params do
            requires :id, type: String, desc: 'Task id'
          end
          get ':id', rabl: 'v1/task_stages/show' do
          end

          desc 'Create task_stage'
          params do
            requires :task_stage, type: Hash, desc: 'Task attributes' do
              requires :task_id, type: String, desc: 'Task id'
              requires :title, type: String, desc: 'Title'
              requires :duration, type: Integer, desc: 'Duration'
              requires :overdue, type: Integer, desc: 'Overdue'
            end
          end
          post '/', rabl: 'v1/task_stages/show' do
            @resource = task.stages.create(permitted_params[:task_stage])
          end

          desc 'Update task_stage'
          params do
            requires :id, type: String, desc: 'Stage id'
            requires :task_stage, type: Hash, desc: 'Task attributes' do
              requires :title, type: String, desc: 'Title'
              requires :duration, type: Integer, desc: 'Duration'
              requires :overdue, type: Integer, desc: 'Overdue'
            end
          end
          put ':id', rabl: 'v1/task_stages/show' do
            resource.update(permitted_params[:task_stage])
          end

          desc 'Destroy task_stage'
          params do
            requires :id, type: String, desc: 'Stage id'
          end
          delete ':id' do
            if resource.destroy
              body false
            else
              render rabl: 'v1/task_stages/show'
            end
          end
        end
      end
    end
  end
end
