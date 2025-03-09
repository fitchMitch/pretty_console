module PrettyConsole
  class PrettyConsoleError < StandardError
  end

  class InvalidColorError < PrettyConsoleError
    def initialize(message='')
      super(message)
    end
  end
end