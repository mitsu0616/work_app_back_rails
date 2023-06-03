class User < ApplicationRecord
  # User:WorkHour = 1:N , Userを削除すると関連するWorkHourも削除 
  has_many :work_hours, dependent: :destroy
end
