class ResultsController < ApplicationController
  def index
    # negativeの平均割合から分岐
    case negativePoint = twitter_analysis
    when 0.90..negativePoint
      kinoko = 1
    when 0.80...0.90
      kinoko = 2
    when 0.70...0.80
      kinoko = 3
    when 0.60...0.70
      kinoko = 4
    when 0.50...0.60
      kinoko = 5
    when 0.40...0.50
      kinoko = 6
    when 0.30...0.40
      kinoko = 7
    when 0.20...0.30
      kinoko = 8
    when 0.10...0.20
      kinoko = 9
    else
      kinoko = 10
    end
    binding.pry
    @result = Result.find(kinoko)
  end

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
    binding.pry

    @ave = nega2/nega.length
    
  end
end
