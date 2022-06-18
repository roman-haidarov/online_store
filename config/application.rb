require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module OnlineStore
  class Application < Rails::Application
    config.load_defaults 5.2
    config.autoload_paths << Rails.root.join('services')
    Dir[Rails.root.join('app', 'interactors', '**', '*.rb')].sort.each { |f| require f }
  end
end
