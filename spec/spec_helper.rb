module SpecHelper

  def sign_up_user
    visit '/'
    fill_in :first_name, :with => "Tom"
    fill_in :last_name, :with => "Wisniewski"
    fill_in :email, :with => "tom@gmail.com"
    fill_in :password, :with => "password"
    fill_in :password_confirmation, :with => "password"
    click_button 'Sign Up'
  end

  def log_in_user
    fill_in :login_email, :with => "tom@gmail.com"
    fill_in :login_password, :with => "password"
    click_button 'Log In'
  end  

end