class LogEntry < ApplicationRecord
  belongs_to :user
  belongs_to :place

  # Validations
  validates :title, presence: true
  validates :description, presence: true
  validates :occurred_on, presence: true
end
