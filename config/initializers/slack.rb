require 'google/apis/vision_v1'
require 'open-uri'

Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
end


client = Slack::RealTime::Client.new

client.on :message do |data|
  if !data.file.nil?
    case data.file.filetype
    when "jpg", "jpeg", "png", "gif" then
      p data.file
      p '-----'
      p data.file.permalink_public
      open(data.file.permalink_public) do |data|
        p data.read
      end
      #client.message channel: data.channel, text: "<@#{data.user}>さんが画像を送信しました"
    end
  end

  Vision = Google::Apis::VisionV1
  vision = Vision::VisionService.new
  vision.key = ENV['CLOUD_VISION_API_KEY']

  features_list = Google::Apis::VisionV1::Feature.new({max_results: 3, type: "TEXT_DETECTION"})
  context = Vision::ImageContext.new({language_hints: ["Japanese"], lant_long_rect: nil})

  #TODO read file from slack-file
  file = nil
  if !file.nil?
    request = Vision::BatchAnnotateImagesRequest.new({
      requests: [
        features: [
          features_list
        ],
        image: Vision::Image.new(
          {content: file , image_context: context }
        )
      ]
    })
  end


end


client.start!
