Lita.configure do |config|
  config.robot.name = "hina"
  config.robot.log_level = :info
  config.robot.adapter = :slack
  config.adapters.slack.token = ENV['SLACK_API_TOKEN']
end
