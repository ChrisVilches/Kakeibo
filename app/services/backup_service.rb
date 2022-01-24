class BackupService
  class << self
    def backup_to_disk(user:, output:)
      result = { user: user.email, backup_date: DateTime.now, data: user_periods_dump(user) }

      File.write(output, result.to_json)
    end

    private

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
