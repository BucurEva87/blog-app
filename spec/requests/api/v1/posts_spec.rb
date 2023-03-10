require 'swagger_helper'

RSpec.describe 'api/posts', type: :request do
  path '/api/v1/users/:user_id/posts'
  random_number = 1 # rand(1..User.count)
  @user = User.find(random_number)

    get 'Retrieves all the posts of the user' do
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :integer
      request_body_example value: { user_id: @user.id }
    end

    response '200', 'posts found' do
      schema type: :array,
        items: {
          type: :object,
          properties: {
            id: { type: :integer },
            title: { type: :string },
            text: { type: :text },
            comments_counter: { type: :integer },
            likes_counter: { type: :integer },
            created_at: { type: :datetime },
            updated_at: { type: :datetime },
            author_id: { type: :integer }
          },
          required: [:id]
        }

      let(:user_id) { user.id }

      run_test!
    end

    response '404', 'No posts found' do
      let(:user_id) { 'invalidID' }
      run_test!
    end
end
