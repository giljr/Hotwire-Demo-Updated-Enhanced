class Room < ApplicationRecord
    has_many :messages, dependent: :destroy
    validates :name, presence: true
    validates :name, uniqueness: true
    validates :name, length: { minimum: 3 }
    validates :name, length: { maximum: 10 }
    broadcasts_to ->(_) { "rooms" } # ensures all rooms broadcast to a global "rooms" stream
end
