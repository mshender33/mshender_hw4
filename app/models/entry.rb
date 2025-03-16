class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :place  # ✅ Ensure Place association is defined
  has_one_attached :image  # ✅ Active Storage for image uploads
end
