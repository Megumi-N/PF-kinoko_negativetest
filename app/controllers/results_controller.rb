class ResultsController < ApplicationController
  before_action :client_pass
  before_action :referrer_root_url?, only: %i(index)

  def index
    twitter_analysis
    @result = Result.find_by!(level: @negative_level)
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

    # @negative_level=(0.21.ceil(1))*10
    # (negative_point/comprehend_list.length)でnegative_pointの平均値を算出し、
    # transcaleで少数第二位までの値を取得、ceilで切り上げを行ってlevelに合致する値を算出する
    @@negative_level = (negative_point/comprehend_list.length).truncate(2).ceil(1)*10
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
