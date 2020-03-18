class HabitStat
  include Mongoid::Document
  include ActiveModel::Validations

  field :status, type: Integer
  field :date, type: Date
  belongs_to :habit
  belongs_to :user

  STATUS_UNDEFINED = 0
  STATUS_COMPLETE = 1
  STATUS_MISSED = 2

  validates :status,
            inclusion: {in: [STATUS_COMPLETE, STATUS_MISSED, STATUS_UNDEFINED]},
            presence: true
  validates :date, date: true, presence: true
end
