require 'test_helper'

class UrlshortTest < ActiveSupport::TestCase
  
  test "create lots" do
    100.times do
      x = Urlshort.new({:target_url=>34423})
      assert x.save
      #puts x.code
    end
  end
  
  test "case sensitive" do
    assert x = Urlshort.new({:target_url=>34423, :code=>'a'}).save
    assert x = Urlshort.new({:target_url=>34423, :code=>'A'}).save
  end
  
  #lots of auto spammers are trying to use my site a s link farm
  #this should elminate it
  test "code and target_url different" do
    assert_raise(ActiveRecord::RecordInvalid) {Urlshort.new({:target_url=>'a', :code=>'a'}).save!}
  end
end
