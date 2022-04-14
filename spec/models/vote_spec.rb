require 'rails_helper'

RSpec.describe Vote, type: :model do
  it "is valid with valid attributes" do
    user = create :user
    post = create :post

    vote = Vote.new(user: user, post: post)

    expect(vote).to be_valid
  end

  it "is not valid with invalid attributes" do
    
    vote = Vote.new(user_id: 1, post_id: 0)
    vote1 = Vote.new()

    expect(vote).to_not be_valid
    expect(vote1).to_not be_valid
  end

  it "is not valid with multiple votes" do
    
    user = create :user
    post = create :post

    vote1 = create :vote, user: user, post: post

    expect(vote1).to be_valid

    expect{create :vote, user: user, post: post}.to raise_error(ActiveRecord::RecordInvalid)
  end

end
