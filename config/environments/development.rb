Megapoc::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log


  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  c = YAML.load(ERB.new(File.read(File.join(Rails.root,"config/database.yml"))).result)[Rails.env]
  DB = Sequel::Model.db = Sequel.connect c
  Sequel::Model.db.sql_log_level = Rails.application.config.log_level || :info

  if ARGV.any?{|p| p =~ /(--sandbox|-s)/}
    # do everything inside a transaction when using rails c --sandbox (or -s)
    DB.pool.after_connect = proc do |conn|
      DB.send(:add_transaction, conn, {})
      DB.send(:begin_transaction, conn, {})
    end
  end

   Sequel::Model.plugin :active_model
   Sequel::Model.plugin :validation_helpers
end
