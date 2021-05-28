class Result < ApplicationRecord
  has_many :result_wise_sayings
  has_many :wise_sayings, through: :result_wise_sayings
end
