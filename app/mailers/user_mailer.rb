class UserMailer < ApplicationMailer
  def notice_email(domain)
    @domain = domain
    emails = @domain.receiver_group.receivers.pluck(:email)
    mail(to: emails, subject: '[Sev-3]SSL certificate expiration notification')
  end
end