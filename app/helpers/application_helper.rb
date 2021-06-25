module ApplicationHelper
  # titleに関するメソッド
  def full_title(title='')
    base_title = ' -きのこネガティブ診断- '
    title.present? ? title + base_title : base_title
  end

  # twitterカードに対するdescriptionのメソッド
  def full_description(description='')
    base_description = ' - ツイートのネガティブ度をきのこで判定しよう！ - '
    base_description.present? ? description + base_description : base_description
  end

  # 参照urlをdevとprodで分けるメソッド
  def full_url(path)
    domain =  Rails.env.development? ? 'http://0.0.0.0:3000' : root_url
    # domain =  Rails.env.development? ? 'http://0.0.0.0:3000' : 'https://kinokoshindan.herokuapp.com'
    "#{domain}#{path}"
  end

  # webpackerのimageをpublicから参照するためのメソッド
  def image_pack_url(name)
    resolve_path_to_image(name)
  end
end
