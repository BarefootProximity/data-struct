# DataStruct

This Gem contains a DataStruct class, which is based on OpenStruct and RecursiveOpenStruct.
This class is similar to a hash, but allows you to access elements via any of the following:
  - Dot Notation (`data.value`)
  - String lookup (`data['value']`)
  - Symbol lookup (`data[:value]`)

This class also includes the following methods for sorting and traversing through the values:
  - `.sort`
  - `.each`
  - `.each_value`
  - `.each_key`
  - `.each_pair`
  - `.each_with_index`
  - `.first`
  - `.children`
  - `.keys`
  - `.values`
  - `.each_child`

It also includes the following methods for loading data from files:
  - '.load(path)'
    - Traverses the path specified, loading all folders and .yml files into a DataStruct object
  - '.reload!'
    - Reloads all data files specified in the load path (useful when watching the data directory for changes).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'data_struct', :git => 'git@github.com:BarefootProximity/data-struct.git'

```

And then execute:

    $ bundle

## Usage

  - Create an initializer to load the data directory into a global DataStruct variable and watch the data directory for changes
  > config/initializers/data.rb
  >```ruby
  > DATA = DataStruct.new(Rails.root.join('data'))
  >
  > # Reload DATA object when any YML files change in data directory
  > if Rails.env.development?
  >   Rails.application.reloaders << Rails.application.config.file_watcher.new([], { Rails.root.join('data') => ['.yml'] }){}
  >
  >   Rails.application.config.to_prepare do
  >     DATA.reload!
  >   end
  > end
  >```

- Data can be accessed in any of the following forms:
  - `DATA.atoms.buttons`
  - `DATA[:atoms][:buttons]`
  - `DATA['atoms']['buttons']`
- DATA elements can be traversed using .each
  - `DATA.atoms.each { |key, value| ... }`
- DATA elements can be sorted using .sort
  - `DATA.atoms.sort`
  - `DATA.atoms.sort { |a, b| ... }`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/data_struct.
