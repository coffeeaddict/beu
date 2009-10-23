
Given /^I am a valid user$/ do
  @user = User.find(1)
  assert !@user.nil?
end

When /^I create a beu$/ do
  beu = Beu.new( :content => "content", :user => @user )
  assert !beu.nil?

  beu.save

  id = beu.id
  assert Beu.exists?(id)
end

Then /^I have a beu$/ do
  user = User.find(1)
  assert user.beus.last.content == "content"
end
