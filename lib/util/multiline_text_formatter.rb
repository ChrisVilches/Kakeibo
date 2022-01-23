module Util
  class MultilineTextFormatter
    MAX_NEW_LINES = 2

    class << self
      def format(text)
        text ||= ''

        lines = text.strip.lines.map(&:squish)

        remove_extra_newline(lines).join
      end

      private

      def remove_extra_newline(str_array)
        result = []

        current = 1

        str_array.each.with_index do |line, idx|
          result << line if line.present?

          current = line.present? ? 1 : current + 1

          result << "\n" if current <= MAX_NEW_LINES && idx < str_array.size - 1
        end

        result
      end
    end
  end
end
