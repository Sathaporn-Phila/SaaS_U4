Before('@user_test') do
    OmniAuth.config.test_mode = true
    Capybara.default_host = 'http://localhost:3000'
  
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      :provider  => "facebook",
      :uid       => '0',
      :info      => {
        :email      => "test",
        :first_name => "test",
        :last_name  => "tset",
        :name       => "test test"
      }
    })
end
  
# #Config Failure case:
# Before('@omniauth_test_failure') do
#     OmniAuth.config.test_mode = true
#         [:default, :facebook].each do |service|
#         OmniAuth.config.mock_auth[service] = :invalid_credentials
#     end
# end

# After('@omniauth_test_failure') do
#     OmniAuth.config.test_mode = false
# end