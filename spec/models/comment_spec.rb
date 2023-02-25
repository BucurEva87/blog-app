require 'rails_helper'

RSpec.describe Comment, type: :model do
  comment = Comment.new(text: 'This is my first comment')
  before(:each) { comment.save }

  context '#increment_comments_counter' do
    it 'should be private' do
      expect { comment.increment_comments_counter }.to raise_error(NoMethodError)
    end
  end
end
