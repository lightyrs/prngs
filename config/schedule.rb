# Hourly Cron
every :hour do
  rake "hourly:init"
end

# Daily Cron
every :day, :at => '4am' do
  rake "daily:init"
end

# Weekly Cron
every :sunday, :at => '12am' do
  rake "weekly:init"
end

# Monthly Cron
every 1.month, :at => "beginning of the month at 2am" do
  rake "monthly:init"
end