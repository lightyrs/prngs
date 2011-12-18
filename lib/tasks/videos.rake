namespace :videos do

  desc "Extract videos from mentions"
  task :lasso, [:scope] => :environment do |t,args|
    Rails.logger.debug("START: #{Time.now}")
    Lasso::Mentions.wrangle
    Rails.logger.debug("END: #{Time.now}")
  end
end