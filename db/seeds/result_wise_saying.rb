# high negative
Result.where(id: 1..3).ids.sort.each do |result_id|
  WiseSaying.where(id: 1..34).ids.sort.each do |wise_saying_id|
    ResultWiseSaying.create(result_id: result_id, wise_saying_id: wise_saying_id)
  end
end

# middle negative
Result.where(id: 4..7).ids.sort.each do |result_id|
  WiseSaying.where(id: 35..57).ids.sort.each do |wise_saying_id|
    ResultWiseSaying.create(result_id: result_id, wise_saying_id: wise_saying_id)
  end
end

# low negative
Result.where(id: 8..10).ids.sort.each do |result_id|
  WiseSaying.where(id: 58..79).ids.sort.each do |wise_saying_id|
    ResultWiseSaying.create(result_id: result_id, wise_saying_id: wise_saying_id)
  end
end
