def full_title(page_title)
  base_title = "MemoRabble"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def sign_in(user)
  visit signin_path
  fill_in "Username",    with: user.username
  fill_in "Password", with: user.password 
  click_button "Sign in"
end
