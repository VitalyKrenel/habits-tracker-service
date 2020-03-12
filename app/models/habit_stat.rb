class HabitStat
  include Mongoid::Document
  field :status, type: Integer
  field :date, type: Date
  embedded_in :user
  embedded_in :habit

  STATUS_UNDEFINED = 0
  STATUS_COMPLETE = 1
  STATUS_MISSED = 2
end
