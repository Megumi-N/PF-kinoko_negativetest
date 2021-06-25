class ResultsController < ApplicationController
  before_action :comming_twitter

  def index
    # negativeの平均割合から分岐
    twitter_analysis
    
    case @ave
    when 0.90...1.00
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
    @result = Result.find(kinoko)
    @wise_sayings = @result.wise_sayings.sample(3)
    @share = twitter_share
  end

  # twitter分析メソッド
  def twitter_analysis
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.credentials.twitter[:api_key]
      config.consumer_secret     = Rails.application.credentials.twitter[:api_secret_key]
      config.access_token        = Rails.application.credentials.twitter[:access_token]
      config.access_token_secret = Rails.application.credentials.twitter[:access_token_secret]
    end
    @user = user_params[:user]
    # binding.pry
    @account = client.user(@user) # アカウントが存在するかどうか確認、一致しなかった場合Twitter::Error::NotFoundが発生
    # @tweets = []
    #
    # # exclude_replies: true => 返信を除去, include_rts: false => retweetを除去
    # client.user_timeline(@user, exclude_replies: true, include_rts: false).take(10).each do |tw|
    #   # ハッシュ、url、空欄、改行、ファイルを削除
    #   @tweets << tw.text.gsub(/#.*$/, "").gsub(/http.*\s/, "").gsub(/[ 　]+/,"").gsub(/\n/,"").gsub(/http.*\z/,"")
    # end

    # twitter_params = {
    #   text_list: @tweets,
    #   language_code: "ja"
    # }
    # comprehend = Aws::Comprehend::Client.new(region: 'us-east-1')
    # nega = comprehend.batch_detect_sentiment(twitter_params).result_list

    # i = 0
    # nega2=0
    # while i < nega.length do
    #   nega2 += nega[i].sentiment_score.negative
    #   i+=1
    # end
    # @ave = (nega2/nega.length).truncate(2)
    # @ave= 0.90
    # @ave= 0.80
    # @ave= 0.70
    # @ave= 0.60
    # @ave= 0.50
    @ave= 0.40
    # @ave= 0.30
    # @ave= 0.20
    # @ave= 0.10
    # @ave= 0.00
  end

  def twitter_share
    case @result.level
    when 1...4
      text = "🍄ネガティブ度:低"
    when 4...8
      text = "🍄ネガティブ度:中"
    else
      text = "🍄ネガティブ度:高"
    end

    base = "https://twitter.com/intent/tweet?text="
    tweet_contents = "🍄#{@account.name}は#{@result.name}タイプ%0a🍄特性：#{@result.feature}%0a🍄ネガティブレベル：#{@result.level}%0a"+ text
    hashtags = "%0a%20%23きのこネガティブ診断%20%20%23きのこ%0a"
    link = "&url=#{request.url}"
    shareURL = base + tweet_contents + hashtags + link
  end

  private

  def user_params
    params.permit(:user)
  end
  
  def comming_twitter
    request.referrer == "https://t.co/" ? redirect_to(root_url) : request.url
  end
end
