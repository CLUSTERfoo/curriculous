namespace :db do
  namespace :test do
    Rails.env = "test"
    task populate: :environment do
      # Users
      @seed_user_1 = User.create!(username: "seed_user_1",
                                  password: "seed_user_1",
                                  password_confirmation: "seed_user_1")

      @seed_user_2 = User.create!( username: "seed_user_2",
                                    password: "seed_user_2",
                                    password_confirmation: "seed_user_2")

      # Memos by seed_user_1
      @memo_1 = @seed_user_1.memos.create(subject: "First seed memo by seed_user_1",
                                          content: "I only have content.")

      @reply_1 = @seed_user_1.memos.create(subject: "Reply to first memo by self",
                                           content: "@#{ @memo_1.token } I only have content.")
      
      # Memos by seed_user_2
      @reply_2 = @seed_user_2.memos.create(subject: "Reply to first memo",
                                           content: "@#{ @memo_1.token } I only have content.")
    end
  end
end
