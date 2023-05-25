# VCDry

[![Test](https://github.com/wamonroe/vcdry/actions/workflows/test.yml/badge.svg?branch=main)](https://github.com/wamonroe/vcdry/actions/workflows/test.yml)

Simple DSL designed with [View Components](https://viewcomponent.org) in mind to
make defining and setting keyword arguments and instance variables easier.

Before:

```ruby
class HeadingComponent < ApplicationComponent
  def initialize(text:, tag: "h1", **options)
    @text = text
    @tag = tag
    @options = options
  end
end
```

After:

```ruby
class HeadingComponent < ApplicationComponent
  include VCDry::DSL

  keyword :text
  keyword :tag, default: "h1"
  other_keywords :options
end
```

## Table of Contents

- [VCDry](#vcdry)
  - [Table of Contents](#table-of-contents)
  - [Installation](#installation)
  - [General Usage](#general-usage)
    - [Overview](#overview)
    - [keyword](#keyword)
    - [other_keywords](#other_keywords)
    - [strict_keywords](#strict_keywords)
    - [remove_keyword](#remove_keyword)
    - [Callbacks](#callbacks)
  - [Types](#types)
  - [Development](#development)
  - [Contributing](#contributing)
  - [License](#license)

## Installation

Add this line to your application's Gemfile:

```ruby
gem "vcdry"
```

And then execute:

```sh
bundle install
```

## General Usage

### Overview

Include `VCDry::DSL` in your component.

```ruby
class ApplicationComponent < ViewComponent::Base
  include VCDry::DSL
end
```

Use the `keyword` method to define a keyword.

```ruby
class MyComponent < ApplicationComponent
  keyword :name
end
```

By default, specifying an unknown keyword results in an error.

```ruby
MyComponent.new(class: "mt-1")
# unknown keyword: :class (VCDry::UnknownArgumentError)
```

To disable this behavior, specify `strick_keywords false`.

```ruby
class MyComponent < ApplicationComponent
  strict_keywords false
end
```

Or, to save those unknown keywords into a variable, use `other_keywords`.

```ruby
class MyComponent < ApplicationComponent
  other_keywords :options
end
```

Keywords specified on a parent component are inherited by a child component.

```ruby
class ApplicationComponent < ViewComponent::Base
  include VCDry::DSL

  other_keywords :options
end

class ParentComponent < ApplicationComponent
  keyword :name
end

class ChildComponent < ParentComponent
  keyword :age
end

ChildComponent.new(name: "Child", age: 7, class: "mt-1").instance_variables
# => [:@name, :@age, :@options]
```

### keyword

Define a keyword variable to read and store to an instance variable when
instantiating a component.

```ruby
class MyComponent
  keyword :name
end
```

Specify a type to typecast the value specified.

```ruby
class MyComponent
  keyword :name, :string
end
```

You can use any of the built-in types or create your own as defined in
[Types](#types). Additionally you can specify a proc to define
your own one off type for a component.

```ruby
class MyComponent
  keyword :name, ->(value) { "custom #{value}" }
end
```

By default, keywords are required. To make a keyword optional, specify a default
value using the `:default` or pass `optional: true`.

```ruby
class MyComponent
  keyword :padding, :integer, optional: true
  keyword :size, :symbol, default: :md
end
```

When specifying a default, you can also pass the value as a proc to resolve the
default value.

```ruby
class MyComponent
  keyword :options, :hash, default: -> { Hash.new }
end
```

You can instruct a keyword to only accept a predefined set of values by using
the `:values` option.

```ruby
class MyComponent
  keyword :size, :symbol, values: [:sm, :md, :lg]
end
```

You can also instruct a keyword to accept an array of values by passing the
`array: true` option.

```ruby
class MyComponent
  keyword :author_ids, :string, array: true
end
```

A child component can override the declaration of a keyword from a parent
component.

```ruby
class MyOtherComponent < MyComponent
  keyword :author_ids, :integer, array: true
end
```

### other_keywords

To gather all keywords not explicitly defined by the `keyword` method, use the
`other_keywords` method.

```ruby
class MyComponent
  keyword :name
  other_keywords :options
end
```

In the example above, the `:name` keyword would be stored in the variable
`@name` while all other keywords specified would be stored in the variable
`@options`.

If you have a custom type defined that acts similarly to a `Hash` (like the
[TagOptions::Hash](https://github.com/wamonroe/tag_options) gem), you can pass
that in to the `other_keywords` declaration.

```ruby
class MyComponent
  other_keywords :options, :tag_options
end
```

**Note**: You must register a custom type using `VCDry::Types.add_type` as
detailed in [Types](#types).

### strict_keywords

By default, if you specify a unknown keyword when instantiating a component an
error will be raised. To silently discard the additional keywords, use the
`strict_keywords false` declaration.

```ruby
class MyComponent
  keyword :name
  strict_keywords false
end
```

To turn it back on for a component that inherits from parent component that
turned off strict keywords, use the `strict_keywords true` declaration.

```ruby
class MyOtherComponent < MyComponent
  strict_keywords true
end
```

### remove_keyword

To remove a keyword specified on a component that inherits from parent
component, use the `remove_keyword` method.

```ruby
class MyOtherComponent < MyComponent
  remove_keyword :name
end
```

### Callbacks

Including `VCDry::DSL` adds support through `ActiveModel::Callbacks` for the
`before_initialize`, `after_initialization`, and `around_initialize` callbacks
to minimize the need to override the initlialize method.

```ruby
class MyComponent < MyComponent
  before_initialize ->() { @links = [] }
  after_intialize :some_method

  private

  def some_method
    # do something fancy
  end
end
```

## Types

The following types are built-in to `vcdry`.

- boolean
- datetime
- hash
- integer
- string
- symbol

Additionally you can define custom, or override built-in, types by using
`VCDry::Types.add_type`.

```ruby
# config/initializers/vcdry_types.rb
VCDry::Types.add_type(:boolean, ->(value) { ActiveRecord::Type::Boolean.new.cast(value) })
VCDry::Types.add_type(:custom_hash, ->(value) { CustomHash.new(value) })
```

## Mix-in Behavior

To mix-in the `keyword` behavior without using the `VCDry::DSL` (and its
initialize method), you can call include `VCDry::Core` instead and then call
`vcdry_parse_keywords` against the hash you wish to parse out keywords from.

The `vcdry_parse_keywords` accepts a hash and returns a hash of all key/value
pairs that were not pulled out as a `keyword`.

> **Note**: Including `VCDry::Core` does not include support for
> `other_keywords`, `strict_keywords`, or enable support for callbacks.

```ruby
class HeadingComponent
  include VCDry::Core

  keyword :size, :symbol, default: :md
  other_keywords :options

  def initialize(text, **options)
    @text = text
    @options = vcdry_parse_keywords(options)
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`bin/rspec` to run the tests. You can also run:

- `bin/console` for an interactive prompt that will allow you to experiment
- `bin/rubocop` to run RuboCop to check the code style and formatting

To build this gem on your local machine, run `bundle exec rake build`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and the created tag, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/wamonroe/vcdry.

## License

The gem is available as open source under the terms of the [MIT
License](https://opensource.org/licenses/MIT).
