module Util
  class MultilineTextFormatter
    MAX_BLANK_LINES_IN_BETWEEN = 1

    class << self
      def format(text)
        text ||= ''

        lines = text.strip.lines.map(&:squish)

        remove_extra_newline(lines, MAX_BLANK_LINES_IN_BETWEEN).join
      end

      private

      def remove_extra_newline(str_array, max_blank_lines_in_between)
        result = []

        current = 0

        str_array.each.with_index do |line, idx|
          result << line if line.present?

          current = line.present? ? 0 : current + 1

          result << "\n" if current <= max_blank_lines_in_between && idx < str_array.size - 1
        end

        result
      end
    end
  end
end
