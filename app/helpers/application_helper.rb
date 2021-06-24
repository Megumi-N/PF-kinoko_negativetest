module ApplicationHelper
  def full_title(title='')
    base_title = ' -きのこネガティブ診断- '
    title.present? ? title +  base_title : base_title
  end
  
  def full_url(path)
    # domain = if Rails.env.development? ? 'http://0.0.0.0:3000' : 'https://kinokoshindan.herokuapp.com/'
    domain =  Rails.env.development? ? 'http://0.0.0.0:3000/' : 'https://kinokoshindan-staging.herokuapp.com/'
    "#{domain}#{path}"
  end
end
