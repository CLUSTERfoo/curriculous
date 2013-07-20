require 'spec_helper'

describe User do
  before do
    @user = User.new(username: "sample_user", email: "sample_user@example.com")
  end

  subject { @user }

  it { should respond_to(:username) }
  it { should respond_to(:email) }
end
