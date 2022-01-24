Rails.application.configure do
  config.after_initialize do
    password = if ENV['ENCRYPTED_MAIL_PASSWORD'].present?
                 Util::Encryption.decrypt(ENV.fetch('ENCRYPTED_MAIL_PASSWORD'))
               else
                 ''
               end

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.smtp_settings = {
      address:              ENV.fetch('MAIL_HOST'),
      port:                 ENV.fetch('MAIL_PORT').to_i,
      user_name:            ENV.fetch('MAIL_USER'),
      password:             password,
      authentication:       :plain,
      enable_starttls_auto: true
    }

    # If this line is removed, "ActionMailer::Base.smtp_settings" contains different data
    # in development and production.
    # In production, the data defined above would not be present.
    ActionMailer::Base.smtp_settings.merge! config.action_mailer.smtp_settings
  end
end
