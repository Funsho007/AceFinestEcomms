class About < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "id", "title", "updated_at", "type", "pamalink"]
  end
end
