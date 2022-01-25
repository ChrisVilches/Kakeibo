class BackupService
  class << self
    def backup_to_disk(user:, output:)
      result = { user: user.email, backup_date: DateTime.now, data: user_periods_dump(user) }

      formatted_path = format_file_path(output)

      File.write(formatted_path, result.to_json)

      formatted_path
    end

    private

    def format_file_path(path)
      values = {
        year:  Date.today.year,
        month: at_least_two_digits(Date.today.month),
        day:   at_least_two_digits(Date.today.day),
        env:   Rails.env
      }

      Util::VariableReplaceFormatter.format(path, values)
    end

    def at_least_two_digits(num) = format('%02d', num)

    def user_periods_dump(user)
      KakeiboSchema.execute(periods_query_string, context: { current_user: user })
                   .to_h
                   .deep_symbolize_keys[:data][:fetchPeriods]
    end

    def periods_query_string
      <<-GRAPHQL
      {
        fetchPeriods {
          name
          initialMoney
          savingsPercentage
          salary
          dailyExpenses
          dateFrom
          dateTo
          days {
            memo
            dayDate
            budget
            expenses {
              cost
              label
            }
          }
        }
      }
      GRAPHQL
    end
  end
end
