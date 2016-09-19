Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
end


client = Slack::RealTime::Client.new

client.on :message do |data|
  client.message channel: data.channel, text: 'HAHAHAHA'
end


client.start!
