#configure smtp settings, if used
#must be done after juggernaut.rb
ActionMailer::Base.smtp_settings = {
  :address        => Juggernaut[:smtp_host],
  :port           => 587,
  :authentication => :plain,
  :user_name      => Juggernaut[:smtp_user_name],
  :password       => Juggernaut[:smtp_password],
}