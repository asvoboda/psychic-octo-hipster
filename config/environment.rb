# Load the rails application
require File.expand_path('../application', __FILE__)
require 'yaml'

# Initialize the rails application
PsychicOctoHipster::Application.initialize!

require File.dirname(__FILE__) + '/../config/environment.rb'

puts Rails.root

if File.exists?(Rails.root.join('config','login.yml'))
    yaml_data = YAML::load(ERB.new(IO.read(File.join(Rails.root, 'config', 'login.yml'))).result)
    APP_CONFIG = HashWithIndifferentAccess.new(yaml_data)
    ENV['muser'] = APP_CONFIG[:muser]
    ENV['mpwd'] = APP_CONFIG[:mpwd]
end

if File.exists?(Rails.root.join('config','s3.yml'))
    yaml_data = YAML::load(ERB.new(IO.read(File.join(Rails.root, 'config', 's3.yml'))).result)
    S3_CONFIG = HashWithIndifferentAccess.new(yaml_data)
    ENV['secret_access_key'] = S3_CONFIG[:secret_access_key]
    ENV['access_key_id'] = S3_CONFIG[:access_key_id]
end

ActionMailer::Base.smtp_settings = {
  :address        => 'smtpout.secureserver.net',
  :port           => '3535',
  :authentication => :plain,
  :user_name      => ENV['email_user'],
  :password       => ENV['email_pass'],
  :domain         => 'andrewsvoboda.me',
  :enable_starttls_auto => true
}