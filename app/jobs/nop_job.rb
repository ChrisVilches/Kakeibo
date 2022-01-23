class NopJob < ApplicationJob
  queue_as :low_priority

  def perform(message: '(none)')
    logger.debug "Job test. Message passed: #{message}"
  end
end
