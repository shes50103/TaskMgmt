class Task < ApplicationRecord
  has_many :task_tags

  validates :title, :description, presence: true

  enum priority: { high: 0, medium: 1 ,low: 2 }
  enum status: { to_do: 0, doing: 1 ,done: 2 }
end
