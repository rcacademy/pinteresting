class Pin < ActiveRecord::Base
  belongs_to :user
  belongs_to :board
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  validates_presence_of :description, :image, :board_id
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def repost(edited_pin, user_object)
    repost_pin = self.dup
    repost_pin.board_id = edited_pin[:board_id]
    repost_pin.user_id = user_object.id
    repost_pin.image = self.image
    repost_pin.original_pin_id = self.id
    repost_pin.save
  end

  def is_repost?
    original_pin_id.present?
  end

  def original_pin
    Pin.find_by(id: original_pin_id) if is_repost?
  end

end
