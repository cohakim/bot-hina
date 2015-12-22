require 'lita'
require 'lita-slack'
require 'hina/weekly_review'
require "active_support"
require "active_support/core_ext"

module Hina
  Lita.configure do |config|
    config.robot.name           = 'hina'
    config.robot.log_level      = :info
    config.robot.adapter        = ENV['ADAPTER'] || :slack
    config.adapters.slack.token = ENV['SLACK_API_TOKEN']
  end
  Lita.register_handler(Lita::Handlers::WeeklyReview)
end
