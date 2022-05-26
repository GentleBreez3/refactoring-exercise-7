class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
    has_many :followees, through: :followed_users
    has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
    has_many :followers, through: :following_users

    scope :search_user_name, -> (user_name) { where(name: user_name) }
    scope :search_post_title, -> (post_title)  { joins(:posts).where("posts.title =? ", post_title) }
    scope :good_posts, -> {joins(:posts).where("posts.like_count >= ?", 10)}


    def total_like_count
        self.posts.sum(:like_count)
    end
end
