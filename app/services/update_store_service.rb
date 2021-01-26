# frozen_string_literal: true

class UpdateStoreService
  require 'ostruct'

  def initialize(store_id, store_params)
    @store_id = store_id
    @store_params = store_params
  end

  def call
    update_store
  rescue StandardError => e
    OpenStruct.new(success?: false,
                   error: e.message)
  else
    OpenStruct.new(success?: true,
                   error: nil)
  end

  private

  def fetch_store
    Store.find(@store_id)
  end

  def delete_old_photo
    Cloudinary::Uploader.destroy(fetch_store.photos.key, options = {}) if @store_params['photos'].nil? == false
  end

  def update_store
    delete_old_photo
    fetch_store.update(@store_params)
  end

  def product_params
    params.require(:product).permit(:presentation, :name, :photos)
  end
end
