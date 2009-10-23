Given /^I am an anonymous lurker$/ do
  assert true
end

When /^I create a user$/ do
  user = User.new
  user.name = "created"
  user.username = "created"
  user.password = "created"
  user.password_confirm = "created"
  user.email = "created@theinternet.com"
  user.save
  @id = user.id

  assert User.exists?(@id)


end

Then /^I have a user$/ do
  user = User.find(@id)

  assert user.name == "created"
end
