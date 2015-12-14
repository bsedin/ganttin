module Ganttin
  module API
    class V1::Tasks < ::Grape::API
      resource :tasks do
        before do
          authenticate!
        end

        helpers do
          def resource
            @resource ||= current_user.tasks.where(id: params[:id]).first!
          end

          def collection
            @collection ||= current_user.tasks
          end

          alias_method :tasks, :collection
          alias_method :task, :resource
        end

        desc 'Get tasks list'
        params do
          optional :q, type: Hash, default: {}, desc: 'Search query'
        end
        get '/', rabl: 'v1/tasks/index' do
          @collection = collection.search(permitted_params[:q]).result.paginate(page: page)
          ensure_range_headers_for(collection)
        end

        desc 'Get task'
        params do
          requires :id, type: String, desc: 'Task id'
        end
        get ':id', rabl: 'v1/tasks/show' do
        end

        desc 'Create task'
        params do
          requires :task, type: Hash, desc: 'Task attributes' do
            requires :project_id, type: String, desc: 'Project id'
            requires :title, type: String, desc: 'Title'
            optional :body, type: String, desc: 'Description'
          end
        end
        post '/', rabl: 'v1/tasks/show' do
          @resource = current_user.tasks.create(permitted_params[:task])
        end

        desc 'Update task'
        params do
          requires :id, type: String, desc: 'Task id'
          requires :task, type: Hash, desc: 'Task attributes' do
            requires :title, type: String, desc: 'Title'
            optional :body, type: String, desc: 'description'
          end
        end
        put ':id', rabl: 'v1/tasks/show' do
          resource.update(permitted_params[:task])
        end

        desc 'Destroy task'
        params do
          requires :id, type: String, desc: 'Task id'
        end
        delete ':id' do
          if resource.destroy
            body false
          else
            render rabl: 'v1/tasks/show'
          end
        end

        mount V1::TaskStages
      end
    end
  end
end
