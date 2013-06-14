require 'test_helper'

class Tte::GameTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "fails with empty email" do
    g = Tte::Game.new
    assert_raise(ActiveRecord::RecordInvalid) {!g.save!}
  end
  
  test "fails with bad email" do
    g = Tte::Game.new :player_a_email => 'not an email', :player_b_email => 'a@b.com'
    assert_raise(ActiveRecord::RecordInvalid) {!g.save!}
  end
  
  test "valid email addresses" do
    g = Tte::Game.new :player_a_email=>'a@b.com', :player_b_email=>'a+allowextra@b.com'
    assert g.save!
  end
end
