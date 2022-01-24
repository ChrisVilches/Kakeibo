module Util
  class VariableReplaceFormatter
    class << self
      def format(string, values = {})
        string.gsub(replaceable_variable_regex) do |var_with_curly_braces|
          var_name = var_with_curly_braces[1..(var_with_curly_braces.length - 2)].strip.to_sym

          raise "key :#{var_name} not present in values map" unless values.key?(var_name)

          values[var_name]
        end
      end

      private

      def replaceable_variable_regex
        @replaceable_variable_regex ||= /{\s*[a-zA-Z0-9_]+\s*}/
      end
    end
  end
end
