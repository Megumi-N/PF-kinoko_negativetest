class ResultsController < ApplicationController
  before_action :client_pass
  before_action :referrer_root_url?, only: %i(index)

  def index
    negative_level = Twitter::NegativeLevelCaluculationService.call(screen_name: params[:user], client: @client)
    @result = Result.find_by(level: negative_level)
    @wise_sayings = @result.wise_sayings.sample(3)
    @account = @client.user(@user)
    @share = twitter_share
  end

  def twitter_share
    text = @result.negative_degree
    base = "https://twitter.com/intent/tweet?text="
    # text部分はエンコード化することで400エラーを防ぐことができる
    tweet_contents = "#{URI.encode_www_form_component(@account.name)}さんは...%0a#{@result.name}タイプ%0a🍄特性:#{@result.feature}%0a🍄ネガティブレベル:#{@result.level}%0a"+ text + "%0a%23きのこ%20%0a%23きのこネガティブ診断%20%0a"
    # add_url_parameter
    # shareURL = base + tweet_contents + @url_parameter
    shareURL = base + tweet_contents + root_url
  end

  private

  def add_url_parameter
    @url_parameter = url_for(controller: 'results', action: :index, id: SecureRandom.hex(10))
  end
end
