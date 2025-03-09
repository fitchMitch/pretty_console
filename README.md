# PrettyConsole

PrettyConsole adds colors to your console using the [bash colorization codes](http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html).

## Use

#### puts_in_< color >

    PrettyConsole.puts_in_green('Some wording')

prints the following with standard system font
$${\color{green} Some\space wording}$$


##### Colors
where 'green' is a < color > that might be replaced with the following colors :
- red,
- green (as used)
- yellow
- blue
- purple
- cyan
- heavy_white
- and green

#### say_in_< color >

    PrettyConsole.say_in_<color>('Some wording')

prints the following with standard system font
$${\color{green} =====>\space Some\space wording\space<=====}$$

#### print_in_< color >

    PrettyConsole.print_in_<color>('x')

prints the following with standard system font
$${\color{green}x}$$


#### say_with_color_background

    PrettyConsole.say_with_<color>_background('Some wording')

#### announce_task

    desc 'your task'
    task your_task: :environment do |task|
      PrettyConsole.announce_task(task or string) do
        ...your task code
      end
    end

- prints a colored header with the task name and a footer
- it displays the time elapased inside the block

## Installation

Add this line to your application's Gemfile:

    gem 'pretty_console'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pretty_console


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


&copy; Etienne Weil

[LICENSE](LICENSE.txt)