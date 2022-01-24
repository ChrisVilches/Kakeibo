Rails.application.configure do
  config.after_initialize do
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.smtp_settings = {
      address:              ENV.fetch('MAIL_HOST'),
      port:                 ENV.fetch('MAIL_PORT'),
      user_name:            ENV.fetch('MAIL_USER'),
      password:             Util::Encryption.decrypt(ENV.fetch('ENCRYPTED_MAIL_PASSWORD')),
      authentication:       :plain,
      enable_starttls_auto: true
    }
  end
end
