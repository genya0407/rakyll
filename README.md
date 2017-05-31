# Rakyll

[Hakyll](https://jaspervdj.be/hakyll/)-inspied **static site generator**.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rakyll'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rakyll

## Usage

[This](https://github.com/genya0407/blog) is an example.

- You need `templates` directory.
  - You write html template with erb, and place it in `templates`.
- You might need a directory to place markdown contents.
  - In the example above, its name is `products`.
- You might need a directory to place static files(js, css, images).
  - In the example above, its name is `assets`.

Then, write `site.rb`, execute `ruby site.rb`, and `_site` directory will be generated.