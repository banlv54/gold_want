class User < ActiveRecord::Base
  LIKE_TYPES = %W{Like::LikeComment Like::LikeWant Like::LikeAdvertise}

  has_many :received_notices, class_name: NoticeRecipient.name, foreign_key: :receiver_user_id, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :friends

  def do_like target_id, type
    return false unless LIKE_TYPES.include?(type.to_s)
    like = type.to_s.constantize.new target_id: target_id, user_id: self.id
    return like.save
  end
  def do_comment advertise_id, comment
    Comment::CommentAdvertise.create advertise_id: advertise_id, user_id: self.id, comment: comment
  end
  has_many :user_shops
  has_many :shops, through: :user_shops

  has_one :shop, foreign_key: :owner_id
  has_one :role
end
