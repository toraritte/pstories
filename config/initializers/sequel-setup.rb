# initializer skeleton from rodrigo rosenfeld rosas - http://rosenfeld.herokuapp.com/en/articles/2012-04-18-getting-started-with-sequel-in-rails
# YAML load idea from jeremy evans - https://groups.google.com/forum/#!topic/sequel-talk/MGhcXoeGzfM
config = YAML.load(File.read(File.join(Rails.root,'config/database.yml')))[Rails.env]
config['logger'] = [Rails.logger, Logger.new("log/#{Rails.env}_db.log")]
config['logger'] << Logger.new(STDOUT) if Rails.env.development?
DB = Sequel::Model.db = Sequel.connect config
Sequel::Model.db.sql_log_level = Rails.application.config.log_level || :info

if ARGV.any?{|p| p =~ /(--sandbox|-s)/}
  # do everything inside a transaction when using rails c --sandbox (or -s)
  DB.pool.after_connect = proc do |conn|
    DB.send(:add_transaction, conn, {})
    DB.send(:begin_transaction, conn, {})
  end
end

# Sequel::Model.plugin :active_model
# Sequel::Model.plugin :validation_helpers
