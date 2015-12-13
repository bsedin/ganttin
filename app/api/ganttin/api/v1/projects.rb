module Ganttin
  module API
    class V1::Projects < ::Grape::API
      resource :projects do
        before do
          authenticate!
        end

        helpers do
          def resource
            @resource ||= current_user.projects.where(id: params[:id]).first!
          end

          def collection
            @collection ||= current_user.projects
          end

          alias_method :projects, :collection
          alias_method :project, :resource
        end

        desc 'Get projects list'
        params do
          optional :q, type: Hash, default: {}, desc: 'Search query'
        end
        get '/', rabl: 'v1/projects/index' do
          @collection = collection.search(permitted_params[:q]).result.paginate(page: page)
          ensure_range_headers_for(collection)
        end

        desc 'Get project'
        params do
          requires :id, type: String, desc: 'Project id'
        end
        get ':id', rabl: 'v1/projects/show' do
        end

        desc 'Create project'
        params do
          requires :project, type: Hash, desc: 'Project attributes' do
            requires :title, type: String, desc: 'Title'
          end
        end
        post '/', rabl: 'v1/projects/show' do
          @resource = current_user.projects.create(permitted_params[:project])
        end

        desc 'Update project'
        params do
          requires :id, type: String, desc: 'Project id'
          requires :project, type: Hash, desc: 'Project attributes' do
            requires :title, type: String, desc: 'Title'
          end
        end
        put ':id', rabl: 'v1/projects/show' do
          resource.update(permitted_params[:project])
        end

        desc 'Destroy project'
        params do
          requires :id, type: String, desc: 'Project id'
        end
        delete ':id' do
          if resource.destroy
            body false
          else
            render rabl: 'v1/projects/show'
          end
        end
      end
    end
  end
end
