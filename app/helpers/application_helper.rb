module ApplicationHelper
  def full_title(title='')
    base_title = ' -きのこネガティブ診断- '
    title.present? ? title +  base_title : base_title
  end
end
