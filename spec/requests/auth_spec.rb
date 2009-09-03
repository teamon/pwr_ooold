require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "Authentication" do
  before(:each) do
    User.all.destroy!
  end
  
  it "should display login form" do
    create_user "teamon", :admin => true
    log_out
    
    visit "/login"
    fill_in "Login", :with => "teamon"
    fill_in "Hasło", :with => "mapex"
    resp = click_button "Zaloguj"
    
    resp.should have_message("Authenticated Successfully")
    
    resp = visit "/"
    resp.should_not have_message("Authenticated Successfully")
  end
  
  it "should allow to logout" do
    create_user "teamon"
    log_in_as "teamon"
    
    visit "/"
    resp = click_link "Wyloguj"
    resp.should have_message("Logged Out")
  end
  
end

# describe "Authorization" do
#   before(:all) do
#     User.all.destroy!
#     create_user "teamon", :admin => true
#     create_user "eric"
#   end
#   
#   before(:each) do
#     log_out
#   end
#   
#   describe "sites" do
#     specify "sites should require admin privileges" do
#       resp = visit "/sites"
#       resp.should_not be_successful
#     
#       log_in_as "eric"
#       resp = visit "/sites"
#       resp.should be_successful
#     
#       log_in_as "teamon"
#       resp = visit "/sites"
#       resp.should be_successful
#     end
#     
#     specify "sites/new should require admin privileges" do
#       resp = visit "/sites/new"
#       resp.should_not be_successful
#     
#       log_in_as "eric"
#       resp = visit "/sites/new"
#       resp.should_not be_successful
#     
#       log_in_as "teamon"
#       resp = visit "/sites/new"
#       resp.should be_successful
#     end
#   end
#   
#   describe "users" do
#     %w(users users/new users/1/edit).each do |path|
#       specify "#{path} should require admin privileges" do
#         resp = visit "/#{path}"
#         resp.should_not be_successful
#       
#         log_in_as "eric"
#         resp = visit "/#{path}"
#         resp.should_not be_successful
#       
#         log_in_as "teamon"
#         resp = visit "/#{path}"
#         resp.should be_successful
#       end
#     end
#   end
#   
#   describe "profile" do
#     %w(profile/edit).each do |path|
#       specify "#{path} should require to be logged in" do
#         resp = visit "/#{path}"
#         resp.should_not be_successful
#       
#         log_in_as "eric"
#         resp = visit "/#{path}"
#         resp.should be_successful
#       
#         log_in_as "teamon"
#         resp = visit "/#{path}"
#         resp.should be_successful
#       end
#     end
#   end
#   
#   
# end
