# The main PrettyConsole driver
# The PrettyConsole class provides methods to print and display strings in various colors and styles
# in the console. It supports both foreground and background colors, as well as bold text.
#
# Constants:
# - COLOR_MAP: A hash mapping color names to their corresponding ANSI color codes for text.
# - BACKGROUND_COLOR_MAP: A hash mapping color names to their corresponding ANSI color codes for background.
#
# Methods:
# - say_in_<color>(str): Prints the string with the specified color and enhanced formatting.
# - say_in_<color>_loudly(str): Prints the string with the specified color, enhanced formatting, and bold text.
# - puts_in_<color>(str): Prints the string with the specified color.
# - puts_in_<color>_loudly(str): Prints the string with the specified color and bold text.
# - print_in_<color>(str): Prints the string with the specified color without a newline.
# - say_with_<color>_background(str): Prints the string with the specified background color and enhanced formatting.
# - puts_with_<color>_background(str): Prints the string with the specified background color.
# - print_with_<color>_background(str): Prints the string with the specified background color without a newline.
# - announce_task(task): Prints a message indicating the start and end of a task, with timing information.
# - enhance_str(str): Enhances the string with additional formatting.
# - bold(str): Returns the string in bold text.
# - express_in_color(str, color, map = COLOR_MAP): Returns the string formatted with the specified color.
require 'pretty_console/invalid_color_error'

# PrettyConsole is a utility class for printing colored and formatted text to the console.
module PrettyConsole
  # Maps color names to their corresponding ANSI color codes.
  COLOR_MAP = {
      red: 31,
      green: 32,
      yellow: 33,
      blue: 34,
      purple: 35,
      cyan: 36,
      heavy_white: 37
    }

    # Maps background color names to their corresponding ANSI background color codes.
    BACKGROUND_COLOR_MAP = {
      leight: 40,
      red: 41,
      green: 42,
      orange: 43,
      blue: 44,
      purple: 45,
      cyan: 46,
      white: 47
    }
  def self.included(base)
    base.extend self

    # Maps color names to their corresponding ANSI color codes.

    # Dynamically defines methods for printing text in various colors.
    #
    # Example:
    #   PrettyConsole.say_in_red('Hello World')
    #   PrettyConsole.puts_in_green_loudly('Hello World')
    COLOR_MAP.keys.each do |color|
      # Prints the given string in the specified color.
      #
      # @param str [String] the string to print
      define_method("say_in_#{color}".to_sym) do |str|
        puts ''
        puts express_in_color(enhance_str(str), color)
      end

      # Prints the given string in the specified color with bold formatting.
      #
      # @param str [String] the string to print
      define_method("say_in_#{color}_loudly".to_sym) do |str|
        puts ''
        puts express_in_color(enhance_str(bold(str)), color)
      end

      # Prints the given string in the specified color without a newline.
      #
      # @param str [String] the string to print
      define_method("puts_in_#{color}".to_sym) do |str|
        puts express_in_color(str, color)
      end

      # Prints the given string in the specified color with bold formatting without a newline.
      #
      # @param str [String] the string to print
      define_method("puts_in_#{color}_loudly".to_sym) do |str|
        puts express_in_color(bold(str), color)
      end

      # Prints the given string in the specified color without a newline.
      #
      # @param str [String] the string to print
      define_method("print_in_#{color}".to_sym) do |str|
        print express_in_color(str, color)
      end

      # Dynamically defines methods for printing text with various background colors.
      #
      # Example:
      #   PrettyConsole.say_with_red_background('Hello World')
      #   PrettyConsole.puts_with_green_background('Hello World')
      BACKGROUND_COLOR_MAP.keys.each do |color|
        # Prints the given string with the specified background color.
        #
        # @param str [String] the string to print
        define_method("say_with_#{color}_background".to_sym) do |str|
          puts express_in_color(enhance_str(str), color, BACKGROUND_COLOR_MAP)
        end

        # Prints the given string with the specified background color without a newline.
        #
        # @param str [String] the string to print
        define_method("puts_with_#{color}_background".to_sym) do |str|
          puts express_in_color(str, color, BACKGROUND_COLOR_MAP)
        end

        # Prints the given string with the specified background color without a newline.
        #
        # @param str [String] the string to print
        define_method("print_with_#{color}_background".to_sym) do |str|
          print express_in_color(str, color, BACKGROUND_COLOR_MAP)
        end
      end

      # Announces the start and end of a task, printing the task name and duration.
      #
      # @param task [String, Object] the task to announce
      # @yield the block representing the task to be executed
      def self.announce_task(task)
        label = task.is_a?(String) ? task : task&.name
        return unless label

        puts_with_green_background "-- Starting task : #{label}"
        start_time = Time.now
        yield
        end_time = Time.now
        puts ''
        puts_in_blue_loudly "-------- Task completed. Took #{end_time - start_time} seconds"
        puts_in_green "-- end #{label} ----"
      end

      # Enhances the given string by adding decorative markers.
      #
      # @param str [String] the string to enhance
      # @return [String] the enhanced string

      private


      def enhance_str(str)
        "=====> #{str} <====="
      end

      # Makes the given string bold.
      #
      # @param str [String] the string to bold
      # @return [String] the bolded string
      def bold(str)
        "\x1b[1m#{str}\x1b[0m"
      end

      # Colors the given string using the specified color map.
      #
      # @param str [String] the string to color
      # @param color [Symbol] the color to use
      # @param map [Hash] the color map to use (default: COLOR_MAP)
      # @return [String] the colored string
      # @raise [InvalidColorError] if the color is not found in the map
      def express_in_color(str, color, map = COLOR_MAP)
        raise InvalidColorError, " color: #{color}" unless map.key?(color.to_sym)

        "\e[#{map[color.to_sym]}m#{str}\e[0m"
      rescue InvalidColorError => e
        "There's no method called #{color} here -- please try again with " \
        "one of the following colors: red, green, yellow, blue, purple, cyan," \
        "#{e}"
      end
    end
  end
end

