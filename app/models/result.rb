class Result < ApplicationRecord
  has_many :result_wise_sayings
  has_many :wise_sayings, through: :result_wise_sayings

  def negative_degree
    case level
    when 1...4
      "πγγ¬γγ£γεΊ¦:δ½"
    when 4...8
      "πγγ¬γγ£γεΊ¦:δΈ­"
    else
      "πγγ¬γγ£γεΊ¦:ι«"
    end
  end
end
