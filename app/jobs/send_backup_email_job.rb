class SendBackupEmailJob < ApplicationJob
  queue_as :low_priority

  def perform
    AdminMailer.backup_data_email.deliver_now!
    logger.info 'Backup e-mail OK'
  rescue StandardError => e
    logger.error "E-mail failed: #{e}\n#{e.backtrace.join("\n")}"
  end
end
