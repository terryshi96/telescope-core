class ApplicationMailer < ActionMailer::Base
  default from: SmtpSetting.from
  layout 'mailer'
end
