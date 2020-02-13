# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@turingturtorial.io'
  layout 'mailer'
end
