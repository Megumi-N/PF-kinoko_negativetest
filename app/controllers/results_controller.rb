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

    @account = client.user(@user) # アカウントが存在するかどうか確認、一致しなかった場合Twitter::Error::NotFoundが発生

    @tweets = []
    client.user_timeline(@user, exclude_replies: true, include_rts: false).take(1).each do |tw|
      @tweets << tw.text
    end

    # twitter_params = {
    #   text_list: @tweets,
    #   language_code: "ja"
    # }

    # comprehend = Aws::Comprehend::Client.new(region: 'us-east-1')
    # nega = comprehend.batch_detect_sentiment(twitter_params).result_list

    # i=0
    # nega2=0
    # while i < nega.length
    #   nega2 = nega[i].sentiment_score.negative
    #   i+=1
    # end

    # @ave = (nega2/nega.length).truncate(2)
    @ave = 0.80

  end

  def twitter_share
    case @result.level
    when 1...3
      text = "ネガティブ度低め。元気いっぱい！"
    when 4...7
      text = "ネガティブ度はまぁまぁ。程よいネガティブ度。"
    else
      text = "ネガティブ度高め。だいぶお疲れのようす。"
    end

    base = "https://twitter.com/intent/tweet?text="

    tweet_contents = "あなたの直近のツイートは#{@result.name}タイプです。%0a「#{@result.feature}」な特性を持っています。%0a#{@account.name}さんのツイートネガティブレベルは#{@result.level}！%0a" + text
    hashtags = "&hashtags=きのこネガティブ診断,きのこ"
    link = "&url=https://kinokoshindan.herokuapp.com"

    shareURL = base + tweet_contents + hashtags + link

  end

  private

  def user_params
    params.permit(:user)
  end


end
