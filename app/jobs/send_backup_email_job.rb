class SendBackupEmailJob < ApplicationJob
  queue_as :low_priority

  def perform
    logger.info 'Sending backup...'
    AdminMailer.backup_data_email.deliver_now
  end
end
