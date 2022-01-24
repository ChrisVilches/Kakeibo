class AdminMailer < ApplicationMailer
  def backup_data_email
    user = User.find_by_email ENV.fetch 'ADMIN_EMAIL_ADDRESS'
    @periods = user.periods
    @generated_date = DateTime.now
    mail(to: user.email, subject: 'Backup data')
  end

  def summary_email
    @users = User.all
    @periods = Period.all
    @days = Day.all
    @expenses_all = Expense.all
    @discarded_expenses = Expense.discarded

    mail(to: ENV.fetch('ADMIN_EMAIL_ADDRESS'), subject: 'Kakeibo App Summary')
  end
end
