Dir.glob(File.join(Rails.root, 'db', 'seeds', 'result.rb')) { |file| load(file) }
Dir.glob(File.join(Rails.root, 'db', 'seeds', 'wise_saying.rb')) { |file| load(file) }
Dir.glob(File.join(Rails.root, 'db', 'seeds', 'result_wise_saying.rb')) { |file| load(file) }