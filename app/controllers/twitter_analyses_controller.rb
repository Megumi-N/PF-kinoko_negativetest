class TwitterAnalysesController < ApplicationController
 
  def twitter_analysis
    client = Twitter::REST::Client.new do |config|
      config.consumer_key           = Rails.application.credentials.twitter[:api_key]
      config.consumer_secret        = Rails.application.credentials.twitter[:api_secret_key]
      # config.access_token           = Rails.application.credentials.twitter[:access_token]
      # config.access_token_secret    = Rails.application.credentials.twitter[:access_token_secret]
    end

    @tweets = []
    client.user_timeline("wiwiwi20d", exclude_replies: true, include_rts: false).take(2).each do |tw|
      @tweets << tw.text
    end
    
    params= {
      text_list: @tweets,
      language_code: "ja"
    }


    comprehend = Aws::Comprehend::Client.new(region: 'us-east-1')
    nega = comprehend.batch_detect_sentiment(params).result_list
    
    i=0
    nega2=0
    while i < nega.length
      nega2 = nega[i].sentiment_score.negative
      i+=1
    end
    
    @ave = nega2/nega.length    
  end
end
