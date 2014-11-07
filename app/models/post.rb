class Post < ActiveRecord::Base

  belongs_to :user
  has_many :comments, dependent: :destroy
  default_scope -> { order('created_at DESC') }
  validates :user, presence: true
  validates :content, presence: true
  belongs_to :tag
  validates :tag, presence: true
  has_many :megustas, dependent: :destroy


  def usuario_puso_me_gusta?(user)

    @megusta = Megusta.where(post_id: self.id, user: user)[0]

  end

end
