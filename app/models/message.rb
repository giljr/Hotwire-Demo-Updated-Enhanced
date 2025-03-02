class Message < ApplicationRecord
  belongs_to :room
  broadcasts_to :room
  validates :content, presence: true # Ensures content cannot be blank
end
