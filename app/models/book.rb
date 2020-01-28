class Book < ApplicationRecord

	belongs_to :user
	attachment :profile_image
	has_many :books_comments,dependent: :destroy
	has_many :favorites,dependent: :destroy

	validates :title, presence: true
    validates :body, presence: true, length: { maximum: 200 }

    # 解説はメモしている
    def favorite_by?(user)
    	favorites.where(user_id: user.id).exists?
    end

end
