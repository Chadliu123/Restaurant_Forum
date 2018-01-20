class Followship < ApplicationRecord
  belongs_to :user
  belongs_to :following, class_name: "User"
  validates_uniqueness_of :following_id, :scope => :user_id
end
