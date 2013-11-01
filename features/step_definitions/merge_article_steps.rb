Given /^the following users exist:$/ do |user_table|
  user_table.hashes.each do |user|
    user.tap do |u|
      u["profile"] = Profile.find_by_label(u["profile"])
    end
    User.create! user
  end
end

Given /^the following articles exist:$/ do |article_table|
  article_table.hashes.each do |article|
    article.tap do |a|
      a["user"] = User.find_by_login(a["user"])
    end
    Article.create! article
  end
end

Given /^the following comments exist:$/ do |comment_table|
  comment_table.hashes.each do |comment|
    comment.tap do |c|
      c["article"] = Article.find_by_title(c["article"])
    end
    Comment.create! comment
  end
end

Given /^I am logged in with "(.*?)" and password "(.*?)"$/ do |login, password|
  visit '/accounts/login'
  
  fill_in 'user_login', :with => login
  fill_in 'user_password', :with => password
  click_button 'Login'

  if page.respond_to? :should
    page.should have_content('Login successful')
  else
    assert page.has_content?('Login successful')
  end

end
