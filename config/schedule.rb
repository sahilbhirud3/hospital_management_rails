# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# set :output, "log/cron.log"
# every 1.minutes do
#   runner "AppointmentsHelper.update_status_job"
# end

every 1.day, at: '00:00' do
  runner "AppointmentsHelper.update_status_job"
end

#commands after updating file
# whenever --update-crontab
# whenever --update-crontab --set environment='development'
# bundle exec sidekiq

# Learn more: http://github.com/javan/whenever
