class DonationAppointment < ApplicationRecord
  belongs_to :user
  belongs_to :blood_bank

  validate :appointment_must_be_valid

  validates :scheduled_date, :scheduled_time_start, :scheduled_time_end

  validates :status, presence: true, inclusion: { in: %w(scheduled completed),
              message: "%{value} is not a valid status" }

  def appointment_must_be_valid

    # Guard clause: stop if any required fields are missing to avoid NilClass errors
    return if scheduled_date.blank? || scheduled_time_start.blank? || scheduled_time_end.blank?

    # 1. Date Check
    if scheduled_date < Date.today
      errors.add(:scheduled_date, "cannot be in the past")
    end

    # 2. Start vs End Time Check
    if scheduled_time_start >= scheduled_time_end
      errors.add(:scheduled_time_start, "must be before the end time")
    end

    # 3. Present Day Check
    # If the date is today, the start time must be in the future
    if scheduled_date == Date.today
      current_time = Time.now.strftime("%H:%M:%S")
      if scheduled_time_start.strftime("%H:%M:%S") < current_time
        errors.add(:scheduled_time_start, "cannot be in the past for today's date")
      end
    end

  end

end
