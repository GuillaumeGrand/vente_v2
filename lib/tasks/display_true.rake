# frozen_string_literal: true

namespace :batch do
  desc 'Set display to true'
  task display_true: :environment do
    stores = Store.all

    stores.to_a.each do |store|
      next if store.display == false

      store.display = true
      store.free_count = 0
      store.save
    end
  end
end
