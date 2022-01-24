class BackupToDiskJob < ApplicationJob
  queue_as :low_priority

  def perform(output)
    user = User.find_by_email ENV.fetch 'ADMIN_EMAIL_ADDRESS'
    result_path = BackupService.backup_to_disk(user:, output:)
    logger.info "Saved backup to: #{result_path}"
  end
end
