namespace :videos do

  desc "Extract videos from all mentions"
  task :lasso_all, [:scope] => :environment do |t,args|
    Rails.logger.debug("START: #{Time.now}")
    Lasso::Mentions.wrangle(Mention.all)
    Rails.logger.debug("END: #{Time.now}")
  end

  desc "Extract videos from recently created mentions"
  task :lasso_recent, [:scope] => :environment do |t,args|
    Rails.logger.debug("START: #{Time.now}")
    Lasso::Mentions.wrangle(Mention.created_this_hour)
    Rails.logger.debug("END: #{Time.now}")
  end
end