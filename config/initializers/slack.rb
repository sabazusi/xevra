Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
end


client = Slack::RealTime::Client.new

client.on :message do |data|
  if !data.file.nil?
    case data.file.filetype
    when "jpg", "jpeg", "png", "gif" then
      client.message channel: data.channel, text: "<@#{data.user}>さんが画像を送信しました"
    end
  end
end


client.start!
