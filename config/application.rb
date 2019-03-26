require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MonisslApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.generators.assets = false
    config.generators.helper = false
    config.active_record.default_timezone = :local
    config.time_zone = 'Beijing'
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    require File.expand_path "#{Rails.root}/app/settings/smtp_setting.rb", __FILE__
    smtp = SmtpSetting.smtp
    config.action_mailer.smtp_settings = {
        :address        => smtp.address,
        :domain         => smtp.domain,
        :port           => smtp.port,
        :user_name      => smtp.user_name,
        :password       => smtp.password,
        :authentication => smtp.authentication,
        :enable_starttls_auto => smtp.enable_starttls_auto,
        :openssl_verify_mode => smtp.openssl_verify_mode
    }
    config.encoding = "utf-8"
  end
end
