class SummaryEmailJob < ApplicationJob
  queue_as :low_priority

  def perform
    logger.info 'Sending summary...'
    AdminMailer.summary_email.deliver_later
  end
end
