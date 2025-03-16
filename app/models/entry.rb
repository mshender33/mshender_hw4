class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :place
  has_one_attached :image

  validates :title, :description, :occurred_on, presence: true
end
