class Habit
  include Mongoid::Document

  field :name, type: String
  field :description, type: String, default: nil
  belongs_to :user
  has_many :habit_stats
end
