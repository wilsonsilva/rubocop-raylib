# RuboCop::Raylib

Linter to ensure the correct and optimal usage of the [Raylib gem's](https://github.com/wilsonsilva/raylib-ruby) API.
By leveraging RuboCop, it provides insights and prompts for best practices when using Raylib gem.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add rubocop-raylib --require=false

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install rubocop-raylib

Then add the following to the application's `.rubocop.yml` file:

```yaml
require:
  - rubocop-raylib
```

## Usage

Run RuboCop as usual and it will automatically load the RuboCop Raylib cops together with the standard cops.

For example, given the following Raylib app where `Raylib.end_drawing` and `Raylib.close_window` are missing:

```ruby
require 'raylib'

SCREEN_WIDTH = 640
SCREEN_HEIGHT = 480

Raylib.init_window(SCREEN_WIDTH, SCREEN_HEIGHT, 'My window')
Raylib.set_target_fps(60)

until Raylib.window_should_close # Detect window close button or ESC key
  Raylib.begin_drawing
  Raylib.clear_background(Raylib::WHITE)
  Raylib.draw_text('Hello, Raylib!', 10, 10, 20, Raylib::BLACK)
end
```

Running `rubocop` will produce the following output:

```
Inspecting 1 file
I

Offenses:

app.rb:6:1: I: MemoryManagement/UnpairedResource: Found init_window without a corresponding close_window.
Raylib.init_window(SCREEN_WIDTH, SCREEN_HEIGHT, 'My window')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
app.rb:10:3: I: MemoryManagement/UnpairedResource: Found begin_drawing without a corresponding end_drawing.
  Raylib.begin_drawing
  ^^^^^^^^^^^^^^^^^^^^

1 file inspected, 2 offenses detected
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests.
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the
version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version,
push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wilsonsilva/rubocop-raylib. This project is
intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the
[code of conduct](https://github.com/wilsonsilva/rubocop-raylib/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rubocop::Raylib project's codebases, issue trackers, chat rooms and mailing lists is
expected to follow the [code of conduct](https://github.com/wilsonsilva/rubocop-raylib/blob/main/CODE_OF_CONDUCT.md).
