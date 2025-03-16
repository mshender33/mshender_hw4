require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Ensure that a master key is required for credentials
  config.require_master_key = true  # ✅ Required for production deployments

  # Serve static files (for images, stylesheets, JS) when using Render
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?

  # Enable locale fallbacks for I18n.
  config.i18n.fallbacks = true

  # Suppress deprecation warnings in production logs
  config.active_support.report_deprecations = false

  # Use default logging formatter
  config.log_formatter = ::Logger::Formatter.new

  # Configure logging to STDOUT if required (Render-friendly logging)
  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  # Force SSL (recommended for production)
  config.force_ssl = true  # ✅ Ensures secure HTTPS connection

  # Use PostgreSQL connection pool
  config.active_record.database_selector = { delay: 2.seconds }
  config.active_record.database_resolver = ActiveRecord::Middleware::DatabaseSelector::Resolver
  config.active_record.database_resolver_context = ActiveRecord::Middleware::DatabaseSelector::Resolver::Session

  # Active Storage Configuration (Check if using Amazon S3 or fallback to local)
  config.active_storage.service = ENV["STORAGE_SERVICE"].presence&.to_sym || :local  # ✅ Safer storage config

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false
end
