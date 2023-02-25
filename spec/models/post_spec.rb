require 'rails_helper'

RSpec.describe Post, type: :model do
  post = Post.new(title: 'Post1', text: 'This is my first post', author_id: 1)

  before(:each) { post.save }

  context '#title' do
    it 'should be present' do
      post.title = nil
      expect(post).to_not be_valid
    end

    it 'should not have length > 250' do
      post.title = 'a' * 251
      expect(post).to_not be_valid
    end
  end

  context '#comments_counter' do
    it 'should be an integer' do
      post.comments_counter = 'a'
      expect(post).to_not be_valid
    end

    it 'should be bigger or equal to zero' do
      post.comments_counter = -1
      expect(post).to_not be_valid
    end
  end

  context '#likes_counter' do
    it 'should be an integer' do
      post.likes_counter = 'a'
      expect(post).to_not be_valid
    end

    it 'should be bigger or equal to zero' do
      post.likes_counter = -1
      expect(post).to_not be_valid
    end
  end

  context '#most_recent_comments' do
    before(:each) do
      6.times do |i|
        Comment.new(text: "Comment #{i}", post_id: post.id)
      end
    end

    it 'should return the 5 latest comments' do
      expect(post.most_recent_comments).to eq(Comment.order(created_at: :desc).limit(5))
    end
  end

  context '#increment_post_counter' do
    it 'should be private' do
      expect { post.increment_post_counter }.to raise_error(NoMethodError)
    end
  end
end
