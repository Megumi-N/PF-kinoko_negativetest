class TwitterAnalysesController < ApplicationController
  def twitter_analysis
    client = Twitter::REST::Client.new do |config|
      config.consumer_key           = Rails.application.credentials.twitter[:api_key]
      config.consumer_secret        = Rails.application.credentials.twitter[:api_secret_key]
      # config.access_token           = Rails.application.credentials.twitter[:access_token]
      # config.access_token_secret    = Rails.application.credentials.twitter[:access_token_secret]
    end

    @tweets = []
    client.user_timeline("wiwiwi20d", exclude_replies: true, include_rts: false).take(25).each do |tw|
      @tweets << tw.text
    end
  end
end
