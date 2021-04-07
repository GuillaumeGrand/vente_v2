module API
  module V1
    class Stores < Grape::API
      include API::V1::Defaults
      resource :stores do
        desc "Return all stores"
        get "" do
          Store.all
        end
      desc "Return a store"
        params do
          requires :id, type: String, desc: "ID of the store"
        end
        get ":id" do
          User.where(id: permitted_params[:id]).first!
        end
      end
    end
  end
end
