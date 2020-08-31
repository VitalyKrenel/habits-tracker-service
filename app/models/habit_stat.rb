class HabitStat
  include Mongoid::Document
  include ActiveModel::Validations

  field :status, type: Integer
  field :date, type: Date
  embedded_in :habit

  STATUS_UNDEFINED = 0
  STATUS_COMPLETE = 1
  STATUS_MISSED = 2
  STATUS_NEUTRAL = 3

  validates :status,
            inclusion: {in: [STATUS_COMPLETE, STATUS_MISSED, STATUS_UNDEFINED, STATUS_NEUTRAL]},
            presence: true
  validates :date, date: true, presence: true
end
