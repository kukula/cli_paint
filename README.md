# CLI Paint

## Installation

Install latest Ruby using for example [RVM](https://rvm.io/)

## Usage

Run `bin/run`

You have next commands:

```
enter command:
C 20 4
‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐
|                    |
|                    |
|                    |
|                    |
‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐

enter command:
L 1 2 6 2
‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐
|                    |
|xxxxx               |
|                    |
|                    |
‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐

enter command:
L 6 3 6 4
‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐
|                    |
|xxxxx               |
|    x               |
|    x               |
‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐

enter command:
R 16 1 20 3
‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐
|               xxxxx|
|xxxxx          x   x|
|    x          xxxxx|
|    x               |
‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐

enter command:
B 10 3 o
‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐
|oooooooooooooooxxxxx|
|xxxxxoooooooooox   x|
|    xooooooooooxxxxx|
|    xooooooooooooooo|
‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐

enter command:
Q
<EXITS>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
