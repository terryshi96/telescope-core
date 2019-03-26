# encoding: UTF-8
# frozen_string_literal: true

# https://github.com/binarylogic/settingslogic
class SmtpSetting < Settingslogic
  source "#{Rails.root}/config/smtp.yml"
  namespace Rails.env
end