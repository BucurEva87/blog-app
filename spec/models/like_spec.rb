require 'rails_helper'

RSpec.describe Like, type: :model do
  like = Like.new
  before(:each) { like.save }

  context '#increment_likes_counter' do
    it 'should be private' do
      expect { like.increment_likes_counter }.to raise_error(NoMethodError)
    end
  end
end
