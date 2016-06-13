class Pin < ActiveRecord::Base
  belongs_to :user
  belongs_to :board
  has_many :comments
  has_many :likes
  validates_presence_of :description, :image
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def repost(user_object)
    repost_pin = self.dup
    repost_pin.user_id = user_object.id
    repost_pin.image = self.image
    repost_pin.original_pin_id = self.id
    repost_pin.save
  end

  def like
    self.likes += 1
    self.save
  end

  def is_repost?
    original_pin_id.present?
  end

  def original_post
    Pin.find(original_pin_id) if is_repost?
  end

end
