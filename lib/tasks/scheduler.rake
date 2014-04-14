desc "Check the number of days until IRS!"
task :check_irs => :environment do
  diff = (Date.new(2015, 02, 7) - Date.today).to_i
  day_string = "day".pluralize(diff)
  puts "How many days until IRS? #{diff} #{day_string} until IRS!"
  important_dates = [1, 2, 4, 5, 8, 10, 16, 25, 32, 50, 64, 100, 128, 150, 200, 250, 256, 300, 350, 351, 364]
  if important_dates.include?(diff)
    puts "Today is important! Delivering mail..."
    UserMailer.irs_email(diff).deliver
  end
  puts "done."
end