class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books,dependent: :destroy
  has_many :books_comments,dependent: :destroy
  has_many :favorites,dependent: :destroy




# 自分がフォローしているユーザーの関連
  #フォローする側のUserから見て、フォローされる側のUserを(中間テーブルを介して)集める。なので親はfollowing_id(フォローする側)
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  # 中間テーブルを介して「follower」モデルのUser(フォローされた側)を集めることを「followings」と定義
  has_many :followings,through: :active_relationships, source: :follower


# 自分がフォローされるユーザーの関連
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers,through: :passive_relationships, source: :following
  # attachmentにはカラム名から_idを除いた名前を記述する
  attachment :profile_image




# https://teratail.com/questions/84523 参考
  validates :name, length: {in: 2..20}
  validates :introduction, length: { maximum: 50 }

  def followed_by?(user)
    # 今自分(引数のuser)がフォローしようとしているユーザー(レシーバー)がフォローされているユーザー(つまりpassive)の中から、引数に渡されたユーザー(自分)がいるかどうかを調べる
    passive_relationships.find_by(following_id: user.id).present?
  end
end
