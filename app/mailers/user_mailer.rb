class UserMailer < ActionMailer::Base
  default from: "info@andrewsvoboda.me"
  
  def irs_email(irs)
    @irs = irs
    @users = User.all.map{|u| u.email}
    mail(to: "svoboda.andrew@gmail.com", subject: "IMPORTANT: IRS COUNTDOWN", bcc: @users)
  end
end
