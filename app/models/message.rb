class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_one_attached :image

  validates :content,presence: true,unless: :was_attached?
  # validates :image,presence: true,unless: :content_present?
  def was_attached?
    self.image.attached?
  end
  # def content_present?
  #   self.content.present?
  # end
end
