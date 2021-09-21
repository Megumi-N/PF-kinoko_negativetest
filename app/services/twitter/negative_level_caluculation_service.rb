class Twitter::NegativeLevelCaluculationService
  def self.call(screen_name:, client:)
    new(screen_name: screen_name, client: client).call
  end

  def initialize(screen_name:, client:)
    @screen_name = screen_name
    @client = client
  end

  def call
    @account = client.user(@user) # アカウントが存在するかどうか確認、一致しなかった場合Twitter::Error::NotFoundが発生

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
    @average = (negative_point/comprehend_list.length).truncate(2).ceil(1)*10
  end

  private

  attr_reader :screen_name, :client # インスタンス変数の@がなしで呼び出せるようになる
end
