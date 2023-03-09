class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }

  before_save :set_default_photo

  def most_recent_posts
    Post.where(author_id: id).order(created_at: :desc).limit(3)
  end

  private

  def set_default_photo
    return unless photo.blank?

    self.photo = 'https://www.tenforums.com/attachments/tutorials/146359d1501443008-change-default-account-picture-windows-10-a-user.png?s=db781d9974e669b888847edf87cb6271'
  end
end
