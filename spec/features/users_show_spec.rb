require 'rails_helper'
require 'capybara/rspec'

base_url = 'http://localhost:3000'

random_number = rand(1..User.count)

RSpec.feature 'Users#index view', type: :feature, js: true do
  before(:each) do
    @user = User.find(random_number)
    visit "#{base_url}/users/#{random_number}"
  end

  scenario 'user has his/her image displayed' do
    expect(page.find('img')['src']).to eq @user.photo
  end

  scenario 'username is displayed on the page' do
    expect(page.find(:css, '.user-info h2').text).to eq @user.name
  end

  scenario 'user has the right number of posts' do
    expect(page.find(:css, '.user-info p').text.scan(/\d+/).first.to_i).to equal @user.posts_counter
  end

  scenario 'user has the right bio displayed' do
    expect(page.find(:css, '.user-bio p').text).to eq @user.bio
  end
end

RSpec.feature 'Users#index view', type: :feature, js: true do
  before(:each) do
    @user = User.find(random_number)
    visit "#{base_url}/users/#{random_number}"
  end

  scenario 'user has his/her first three (or less than) posts displayed' do
    page_posts = page.all(:css, '.post')
    page_posts = page_posts.map do |post|
      {
        id: post.find('.post-id').text.scan(/\d+/).first.to_i,
        title: post.find('.post-title a').text,
        text: post.find('.post-body').text
      }
    end

    @user.most_recent_posts.each do |post|
      page_post = { id: post.id, title: post.title, text: post.text }
      expect(page_posts).to include(page_post)
    end
  end

  scenario "the page displays a button that lets me see all the user's posts" do
    button = page.find(:css, '.user-posts-more button a')

    expect(button.text).to eq 'See all posts'
    expect(button['href']).to eq "#{base_url}/users/#{random_number}/posts"
  end
end

RSpec.feature 'Users#index view', type: :feature, js: true do
  before(:each) do
    @user = User.find(random_number)
    visit "#{base_url}/users/#{random_number}"
  end

  scenario 'each post title links to the /users/:id/posts/:post_id page (show action of Posts controller)' do
    @user.most_recent_posts.each.with_index do |post, index|
      article = page.all(:css, '.post .post-title a')[index]

      expected_url = "#{base_url}/users/#{@user.id}/posts/#{post.id}"

      article.click

      expect(page).to have_current_path(expected_url)

      visit "#{base_url}/users/#{random_number}"
    end
  end

  scenario 'clicking on All Posts button redirects me to all posts page' do
    page.find(:css, '.user-posts-more button a').click

    expect(page).to have_current_path("#{base_url}/users/#{random_number}/posts")
  end

  scenario "clicking on Back to user button redirects me to user's page" do
    page.find(:css, '.btn-back').click

    expect(page).to have_current_path("#{base_url}/users/#{random_number}")
  end
end
