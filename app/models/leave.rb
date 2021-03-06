class Leave < ApplicationRecord
  belongs_to :user
  has_many :leave_statuses , dependent: :destroy


  after_create :set_leave_status

  private

  scope :leave_approvals, ->(user) {
    self.joins(:user).where("users.reporting_to= ?" , user.id)
  }


  scope :this_year, -> {
    self.joins(:leave_statuses).where("leaves.start_date > ? AND leave_statuses.status = ? " , Time.now.beginning_of_year, "approved")
  }

  scope :this_month, -> {
    self.joins(:leave_statuses).where("leaves.start_date > ? AND start_date < ? AND leave_statuses.status = ?" , Time.now.beginning_of_month, Time.now.end_of_month, "approved")
  }

  after_create :set_leave_status

  def self.hr_leaves
    Leave.joins(:leave_statuses).where.not("leave_statuses.status='pending' OR leave_statuses.status='rejected by Reporting to'")
  end

  private

  def set_leave_status
    LeaveStatus.create({leave_id: self.id, status: "pending", user_id: self.user.id })
  end

end
