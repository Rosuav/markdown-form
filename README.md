# Markdown Forms

Add this gem to Jekyll to introduce a syntax for creating form elements.

The page's frontmatter and/or layout HTML will need to provide the form, the
destination, and (if applicable) any JavaScript for handling submissions.

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add markdown_form
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install markdown_form
```

## Usage

TODO: Write usage instructions here once I figure out exactly how the syntax is going to be designed.

* Option 1: Form is implicit (or provided by the HTML layout), and {% form Name %} to plop in a field
* Option 2: Form is a block eg {% form %} ...... {% endform %} and inside are {% field Name %}
* Option 3: Fields are eg `[[Name]]` which might conflict with link syntax

Frontmatter can carry extra info eg form destination/action

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rosuav/markdown_form.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
