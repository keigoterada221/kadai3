class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books,dependent: :destroy
  # attachmentにはカラム名から_idを除いた名前を記述する
  attachment :profile_image
# https://teratail.com/questions/84523 参考
  validates :name, length: {in: 2..20}
  validates :introduction, length: { maximum: 50 }
end
