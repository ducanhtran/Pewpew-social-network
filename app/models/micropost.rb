class Micropost < ApplicationRecord
  belongs_to :user
  has_many :comments

  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.models.micropost.content_len}
  validate :picture_size

  scope :newest, ->{order id: :desc}

  private

  def picture_size
    if picture.size > Settings.micropost.picture_size.megabytes
      errors.add :picture, I18n.t("errors.picture_size_error")
    end
  end
end
