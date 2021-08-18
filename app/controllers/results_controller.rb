class ResultsController < ApplicationController
  before_action :client_pass
  before_action :referrer_root_url?, only: %i(index)

  def index
    twitter_analysis
    case @average
    when 0.90..1.00
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
    @user = user_params[:user]

    @account = @client.user(@user) # アカウントが存在するかどうか確認、一致しなかった場合Twitter::Error::NotFoundが発生

    @tweets = []
    @client.user_timeline(@user, exclude_replies: true, include_rts: false).take(5).each do |tw|
      tweet = tw.text.gsub(/#.*$|[ 　]+|\n|http.*:\/\/t.co\/\w*$/,"") # ハッシュ、空欄、改行、twitterの省略url
      @tweets << tweet if tweet.present?
    end

    twitter_params = {
      text_list: @tweets,
      language_code: "ja"
    }
    comprehend = Aws::Comprehend::Client.new(
      region: 'us-east-1',
    )

    comprehend_list = comprehend.batch_detect_sentiment(twitter_params).result_list
    negative_point = 0
    comprehend_list.each_index {|i| negative_point += comprehend_list[i].sentiment_score.negative }
    @average = (negative_point/comprehend_list.length).truncate(2)
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
    # text部分はエンコード化することで400エラーを防ぐことができる
    tweet_contents = "#{URI.encode_www_form_component(@account.name)}さんは...%0a#{@result.name}タイプ%0a🍄特性:#{@result.feature}%0a🍄ネガティブレベル:#{@result.level}%0a"+ text + "%0a%23きのこ%20%0a%23きのこネガティブ診断%20%0a"
    # add_url_parameter
    # shareURL = base + tweet_contents + @url_parameter
    shareURL = base + tweet_contents + root_url
  end

  private

  def user_params
    params.permit(:user)
  end

  def add_url_parameter
    @url_parameter = url_for(controller: 'results', action: :index, id: SecureRandom.hex(10))
  end
end
