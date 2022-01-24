class SummaryEmailJob < ApplicationJob
  queue_as :low_priority

  def perform
    AdminMailer.summary_email.deliver_now!
    logger.info 'Summary e-mail OK'
  rescue StandardError => e
    logger.error "E-mail failed: #{e}\n#{e.backtrace.join("\n")}"
  end
end
