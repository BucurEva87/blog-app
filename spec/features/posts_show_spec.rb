require 'rails_helper'
require 'capybara/rspec'

base_url = 'http://localhost:3000'

random_number = rand(1..User.count)
posts_id = User.find(random_number).posts.map(&:id)
random_post = posts_id[rand(0...posts_id.length)]

RSpec.feature 'Users#index view', type: :feature, js: true do
  before(:each) do
    @user = User.find(random_number)
    visit "#{base_url}/users/#{random_number}/posts/#{random_post}"
  end

  scenario 'post title is visible on the page' do
    expect(page).to have_selector('h2.post-title')
  end

  scenario 'post author is visible on the page' do
    author = page.find(:css, '.post-author')

    expect(author.text).to eq @user.name
  end

  scenario 'the number of comments of the post is shown on the page' do
    number_of_comments = page.find('.post-info').text.scan(/\d+/).first.to_i

    expect(Post.find(random_post).comments_counter).to eq number_of_comments
  end

  scenario 'the number of likes of the post is shown on the page' do
    number_of_likes = page.find('.post-info').text.scan(/\d+/).last.to_i

    expect(Post.find(random_post).likes_counter).to eq number_of_likes
  end
end

RSpec.feature 'Users#index view', type: :feature, js: true do
  before(:each) do
    @user = User.find(random_number)
    visit "#{base_url}/users/#{random_number}/posts/#{random_post}"
  end

  scenario 'the post body is displayed on the page' do
    expect(Post.find(random_post).text).to eq page.find('.post-body').text
  end

  scenario 'the name of each commentor appears on the page' do
    page_commentors = page.all('.post-comments .author-name a').map(&:text)
    post_commentors = Post.includes(comments: :author).find(random_post).comments.map { |c| c.author.name }.reverse

    expect(page_commentors).to eq post_commentors
  end

  scenario 'all the comments are displayed on the page' do
    page_comments = page.all('.comment-body').map(&:text)
    post_comments = Post.includes(comments: :author).find(random_post).comments.map(&:text).reverse

    expect(page_comments).to eq post_comments
  end
end

RSpec.feature 'Users#index view', type: :feature, js: true do
  before(:each) do
    @user = User.find(random_number)
    visit "#{base_url}/users/#{random_number}/posts/#{random_post}"
  end

  scenario "clicking on Back to user button redirects me to user's posts page (index action of Posts controller)" do
    page.find(:css, '.btn-back').click

    expect(page).to have_current_path("#{base_url}/users/#{random_number}/posts")
  end
end
