class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friending, class_name: "User"
  validates_uniqueness_of :friending_id, :scope => :user_id
end
