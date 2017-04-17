class Email
  attr_reader :msg
  def initialize(msg)
    @msg = msg
  end

  def dispatch
    Pony.mail(settings)
  end

  private

  def settings
    {
      :to => msg.email,
      :from => "%s <%s>" % [ENV["FROM_NAME"], ENV["FROM_EMAIL"]],
      :subject => msg.subject,
      :body => msg.body,
      :charset => "UTF-8",
      :via => :smtp,
        :via_options => {
        :address              => ENV["SMTP_SERVER"],
        :port                 => ENV["SMTP_PORT"],
        :enable_starttls_auto => true,
        :user_name            => ENV["SMTP_LOGIN"],
        :password             => ENV["SMTP_PASSWORD"],
        :authentication       => :login,
      }
    }
  end
end
