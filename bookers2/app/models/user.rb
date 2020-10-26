class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy


  has_many :following_relationships,foreign_key: "follower_id", class_name: "Relationship",  dependent: :destroy
  has_many :followings, through: :following_relationships, source: :following
  has_many :follower_relationships,foreign_key: "following_id",class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

  # current_user.following?(@user) <= @user = User.find(2)
  def following?(other_user)
    following_relationships.find_by(following_id: other_user.id)
    # self.followings.include?(other_user)
    # current_user.following_relationships.find_by(following_id: @user.id)
  end

  def follow(other_user)
    following_relationships.create(following_id: other_user.id)
  end

  def unfollow(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end
  
  def self.search(search, word)
    if search == "forward_match"
      @user = User.where("name LIKE?", "#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?", "%#{word}")
    elsif search == "perfect_match"
      @user = User.where(name: word)
    elsif search == "partial_match"
      @user = User.where("name LIKE?", "%#{word}%")
    else
      @user = User.all
    end
  end

  
  # app/models/user.rb に追記
  include JpPrefecture
  jp_prefecture :prefecture_code  # prefecture_codeはuserが持っているカラム

  # postal_codeからprefecture_nameに変換するメソッドを用意します．
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end
  
  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end
  

  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction,
    length: { maximum: 50 }
end