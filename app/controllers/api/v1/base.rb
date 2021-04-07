module API
  module V1
    class Base < Grape::API
      mount API::V1::Stores
    end
  end
end
