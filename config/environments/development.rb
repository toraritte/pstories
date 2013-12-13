Pstories::Application.configure do
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

# initializer skeleton from rodrigo rosenfeld rosas - http://rosenfeld.herokuapp.com/en/articles/2012-04-18-getting-started-with-sequel-in-rails
# YAML load idea from jeremy evans - https://groups.google.com/forum/#!topic/sequel-talk/MGhcXoeGzfM
# ... and it is a nice idea but heroku does not compile this...
# but there is hope: http://stackoverflow.com/questions/18139003/how-to-solve-an-error-in-herokus-config-database-yml-file-mapping-values-are-n
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
   # constraint_validations, auto_validations => both useful for a new project (http://sequel.jeremyevans.net/rdoc/files/doc/validations_rdoc.html)
   Line.dataset = Line.dataset
end
