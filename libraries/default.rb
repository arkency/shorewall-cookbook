module Shorewall
  module Utils
    module_function

    def normalize_value(value)
      case value
      when true, 'true', 'yes', :yes
        'Yes'
      when false, 'false', 'no', :no
        'No'
      else
        value.to_s
      end
    end

    def format_line(line, formatting)
      column = 0
      result = line[:description] ? "\n# #{line[:description]}\n" : ""

      formatting.each do |key, width|
        column += width
        value = line.fetch(key, '-').to_s
        result << value.ljust(width)
        result << " \\\n#{' ' * column}" unless width.zero? || value.length < width
      end
      result
    end
  end
end
