class Place < ApplicationRecord
  has_many :entries  # ✅ Add this line
end
