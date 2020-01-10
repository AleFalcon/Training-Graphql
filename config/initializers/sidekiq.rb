url = "redis://#{ENV.fetch('REDIS_HOST', '127.0.0.1')}:6379"

Sidekiq.configure_server do |config|
  config.redis = { url: url }
end

Sidekiq.configure_client do |config|
  config.redis = { url: url }
end

Sidekiq.default_worker_options = { 'backtrace' => 20 }

if Rails.env.production?
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(
      ::Digest::SHA256.hexdigest(username),
      ::Digest::SHA256.hexdigest(ENV.fetch('SIDEKIQ_USERNAME', 'rails-graphql-bootstrap'))
    ) &
      ActiveSupport::SecurityUtils.secure_compare(
        ::Digest::SHA256.hexdigest(password),
        ::Digest::SHA256.hexdigest(ENV.fetch('SIDEKIQ_PASSWORD', 'rails-graphql-bootstrap'))
      )
  end
end
