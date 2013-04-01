require 'test_helper'

class Facebook::UsersTest < ActiveSupport::TestCase
  
  test 'basic save' do
    x = Facebook::User.new(
      {
        :email=>'a@b.com',
        :app_id => 1,
        :facebook_id => 13,
        :auth => "1",
        :name => "1",
        :status=>1,
        
      }
    )
    assert x.save!
    
    y = Facebook::User.find_by_email('a@b.com')
    assert y.facebook_id == 13
  end
end
