class Twitter::NegativeLevelCaluculationService
  def self.call(screen_name:, client:)
    new(screen_name: screen_name, client: client).call
  end

  def initialize(screen_name:, client:)
    @screen_name = screen_name
    @client = client
  end

  def call
    comprehend = Aws::Comprehend::Client.new( region: 'us-east-1')

    comprehend_list = comprehend.batch_detect_sentiment(twitter_params).result_list
    negative_point = 0
    comprehend_list_length = comprehend_list.each_index {|i| negative_point += comprehend_list[i].sentiment_score.negative }
    (negative_point/comprehend_list_length.length).truncate(2).ceil(1)*10
  end

  private

  attr_reader :screen_name, :client # インスタンス変数の@がなしで呼び出せるようになる

  def tweets
    tweets = []
    client.user_timeline(screen_name, exclude_replies: true, include_rts: false).take(5).each do |tw|
      tweet = tw.text.gsub(/#.*$|[ 　]+|\n|http.*:\/\/t.co\/\w*$/,"") # ハッシュ、空欄、改行、twitterの省略url
      tweets << tweet if tweet.present?
    end
    tweets
  end

  def twitter_params
    {
      text_list: tweets, # tweetsメソッドが呼び出される
      language_code: "ja"
    }
  end
end
