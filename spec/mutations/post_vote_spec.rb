require 'rails_helper'

describe Mutations::PostUpvote do
  let(:object) { :not_used }
  let(:user) { create :user }
  let(:post) { create :post }

  def call(current_user:, context: {}, **args)
    context = Utils::Context.new(
      query: OpenStruct.new(schema: KittynewsSchema),
      values: context.merge(current_user: current_user),
      object: nil,
    )
    described_class.new(object: nil, context: context, field: nil).resolve(args)
  end

  it 'validate new vote' do
    result = call(current_user: user, post_id: post.id)
    expect(result[:post].votes_count).to eq 1
    expect(result[:errors]).to eq []
  end

  it 'validate delete vote' do
    post.votes.create(user: user)
    result = call(current_user: user, post_id: post.id)
    expect(result[:post].votes_count).to eq 0
    expect(result[:errors]).to eq []
  end

  it 'requires valid post id' do
    result = call(current_user: user, post_id: 0)

    expect(result).to eq post: nil, errors: ["record not found"]
  end

  it 'requires a logged in user' do
    expect { call(current_user: nil, post_id: 1) }.to raise_error GraphQL::ExecutionError, 'current user is missing'
  end
end
