require 'minitest/autorun'
require 'pretty_console'
require 'ostruct'

class PrettyConsoleTest < Minitest::Test
  def setup
    @output = StringIO.new
    @original_stdout = $stdout
    $stdout = @output
  end

  def teardown
    $stdout = @original_stdout
  end

  class DummyTask
    def name
      @name
    end

    def initialize(name)
      @name = name
    end
  end

  PrettyConsole::COLOR_MAP.keys.each do |color|
    define_method("test_say_in_#{color}") do
      PrettyConsole.send("say_in_#{color}", 'Hello World')
      assert_includes @output.string, PrettyConsole.express_in_color(PrettyConsole.enhance_str('Hello World'), color)
    end

    define_method("test_say_in_#{color}_loudly") do
      PrettyConsole.send("say_in_#{color}_loudly", 'Hello World')
      assert_includes @output.string, PrettyConsole.express_in_color(PrettyConsole.enhance_str(PrettyConsole.bold('Hello World')), color)
    end

    define_method("test_puts_in_#{color}") do
      PrettyConsole.send("puts_in_#{color}", 'Hello World')
      assert_includes @output.string, PrettyConsole.express_in_color('Hello World', color)
    end

    define_method("test_puts_in_#{color}_loudly") do
      PrettyConsole.send("puts_in_#{color}_loudly", 'Hello World')
      assert_includes @output.string, PrettyConsole.express_in_color(PrettyConsole.bold('Hello World'), color)
    end

    define_method("test_print_in_#{color}") do
      PrettyConsole.send("print_in_#{color}", 'Hello World')
      assert_includes @output.string, PrettyConsole.express_in_color('Hello World', color)
    end

    def test_express_in_color_with_default_map
      result = PrettyConsole.express_in_color('Hello', :red)
      assert_equal "\e[31mHello\e[0m", result
    end

    def test_express_in_color_with_custom_map
      custom_map = { red: 91 }
      result = PrettyConsole.express_in_color('Hello', :red, custom_map)
      assert_equal "\e[91mHello\e[0m", result
    end

    def test_express_in_color_with_invalid_color
      assert_includes PrettyConsole.express_in_color('Hello', :invalid_color),
                      "There's no method called"
    end

    def test_bold
      input = "Hello World"
      expected_output = "\x1b[1mHello World\x1b[0m"
      assert_equal expected_output, PrettyConsole.bold(input)
    end

  end
  def test_announce_task
    task_name = "Sample Task"
    PrettyConsole.announce_task(task_name) do
      sleep 1
    end

    output = @output.string
    assert_includes output, "-- Starting task : Sample Task"
    assert_includes output, "-------- Task completed. Took"
    assert_includes output, "-- end Sample Task ----"
  end

  def test_announce_task_with_object

    task = DummyTask.new(name: "Object Task")
    PrettyConsole.announce_task(task) do
      sleep 1
    end

    output = @output.string
    assert_includes output, "-- Starting task : "
    assert_includes output, "[0m\n\n\e[34m\e[1m-------- Task completed. Took 1."
  end


  PrettyConsole::BACKGROUND_COLOR_MAP.keys.each do |color|
    define_method("test_say_with_#{color}_background") do
      PrettyConsole.send("say_with_#{color}_background", 'Hello World')
      assert_includes @output.string, PrettyConsole.express_in_color(PrettyConsole.enhance_str('Hello World'), color, PrettyConsole::BACKGROUND_COLOR_MAP)
    end

    define_method("test_puts_with_#{color}_background") do
      PrettyConsole.send("puts_with_#{color}_background", 'Hello World')
      assert_includes @output.string, PrettyConsole.express_in_color('Hello World', color, PrettyConsole::BACKGROUND_COLOR_MAP)
    end

    define_method("test_print_with_#{color}_background") do
      PrettyConsole.send("print_with_#{color}_background", 'Hello World')
      assert_includes @output.string, PrettyConsole.express_in_color('Hello World', color, PrettyConsole::BACKGROUND_COLOR_MAP)
    end
  end
end
