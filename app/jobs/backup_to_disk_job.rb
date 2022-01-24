class BackupToDiskJob < ApplicationJob
  queue_as :low_priority

  # TODO: Write backup files in such a way that history is preserved (e.g. backup.2022-01-02.json)

  def perform(output)
    user = User.find_by_email ENV.fetch 'ADMIN_EMAIL_ADDRESS'
    BackupService.backup_to_disk(user:, output:)
    logger.info "Saved backup to: #{output}"
  end
end
