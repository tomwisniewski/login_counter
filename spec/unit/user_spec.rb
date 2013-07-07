require 'rspec'
require_relative '../../lib/models/user'

describe User do

  it 'should build a new user' do
    user = User.build("Tom", "Wis", "t@t.com", "password", "password")
    expect(user.valid?).to be true
    expect(user.save).to be true
  end  

  it "should allow the login count to be updated" do
    user = User.build("Tom", "Wis", "t@t.com", "password", "password")
    user.save
    user_found = User.first()
    user_found.update_login_count(user_found.login_count + 1)
    expect(user_found.login_count).to eq(1)
  end

end 

