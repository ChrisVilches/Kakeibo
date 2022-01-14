module HttpErrors
  class UnprocessableEntityError < StandardError
    attr_reader :messages

    def initialize(record)
      super
      @messages = record.errors.full_messages
    end
  end

  class NotFoundError < StandardError; end
end
