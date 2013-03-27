# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

#juju
Facebook::User.create(:facebook_id=>3202602, :app_id=>1, :auth=>1, :email=>'juju@patt.us', :status=>1)
