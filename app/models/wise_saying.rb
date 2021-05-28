class WiseSaying < ApplicationRecord
  has_many :result_wise_sayings
  has_many :results, through: :result_wise_sayings
end
