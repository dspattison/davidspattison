require 'test_helper'

class UrlshortTest < ActiveSupport::TestCase
  
  test "create lots" do
    100.times do
      x = Urlshort.new({:target_url=>34423})
      assert x.save
      #puts x.code
    end
  end
end
