class Result < ApplicationRecord
  has_many :result_wise_sayings
  has_many :wise_sayings, through: :result_wise_sayings

  def negative_degree
    case level
    when 1...4
      "🍄ネガティブ度:低"
    when 4...8
      "🍄ネガティブ度:中"
    else
      "🍄ネガティブ度:高"
    end
  end
end
