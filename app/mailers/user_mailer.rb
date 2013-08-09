class UserMailer < ActionMailer::Base
  default from: "info@andrewsvoboda.me"
  
  def comment_email(post_id, commenter)
    @url = "http://andrewsvoboda.me/posts/" + post_id
	@commenter = commenter
	mail(to: "svoboda.andrew@gmail.com", subject: "blog comment")
  end
end
