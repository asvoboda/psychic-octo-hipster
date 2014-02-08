desc "This task is called by the Heroku scheduler add-on"
task :check_irs => :environment do
  irs = Date.new(2015, 02, 7)
  today = Date.today
  diff = (irs - today).to_i
  day_string = "day".pluralize(diff)
  puts "How many days until IRS? #{diff} #{day_string} until IRS!"
  important_dates = [1, 2, 4, 8, 10, 16, 25, 32, 50, 64, 100, 128, 200, 256, 300, 364].map {|x| irs - x}
  if important_dates.include?(today)
    UserMailer.irs_email(diff).deliver
  end
  puts "done."
end