class TwitterAnalysis < ApplicationRecord
  attr_accessor :contents

  def initialize(contents)
    @contents = contents
  end
end
