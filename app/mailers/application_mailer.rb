class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('NO_REPLY_ADDRESS')
  default reply_to: ENV.fetch('NO_REPLY_ADDRESS')
  default content_type: 'text/html'
end
