module ApplicationHelper
  def full_title(page_title = "")
    base_title = "きのこネガティブ診断"
    page_title.empty? ? base_title : "#{page_title} - #{base_title}"
  end

  # def full_url(path)
  #   domain= if Rails.env.development?
  #             'http://0.0.0.0:3000/'
  #           else
  #             'https://kinokoshindan.herokuapp.com/'
  #           end
  #   "#{domain}#{path}"
  # end
end
