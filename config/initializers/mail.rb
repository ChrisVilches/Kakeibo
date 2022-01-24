Rails.application.configure do
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.smtp_settings = {
    address:              ENV['MAIL_HOST'],
    port:                 ENV['MAIL_PORT'],
    user_name:            ENV['MAIL_USER'],
    password:             ENV['MAIL_PASSWORD'],
    authentication:       :plain,
    enable_starttls_auto: true
  }
end
