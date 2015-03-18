module Oped
  module Models
    module Mailer extend self
      def prompt!
        now  = Date.current
        text = "Just reply to this email with your entry."

        Mail.deliver do
          to App.to_email
          from App.from_email
          subject "It's #{now.to_s(:wdm)} - What are you grateful for?"
          body text

          charset = 'UTF-8'
          content_transfer_encoding = '8bit'
        end
      end
    end
  end
end
