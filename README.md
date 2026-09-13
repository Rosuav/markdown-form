# Markdown Forms

Add this gem to Jekyll to introduce a syntax for creating form elements.

The page's frontmatter and/or layout HTML will need to provide the form, the
destination, and (if applicable) any JavaScript for handling submissions.

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add markdown_form -g jekyll_plugins
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install markdown_form
```

(TODO: Will Jekyll correctly recognize it in this situation? Does it need to be told to look for it?)

## Usage

Include a form destination in your frontmatter eg `form: some-action` and have your layout HTML, CSS, and JS
handle this appropriately. The form element itself will not be created in Markdown.

Create form fields using `[[Field with some descriptive text]]` syntax; they will be contained within labels,
and styling `label > span { ... }` will affect the label without the input.

By default, the first word of the descriptive text will become the field's name. To override this, emphasize
some other word, eg `[[Enter your *widget* name]]` to name the field "widget". If the desired name does not
occur in the label, provide it as an annotation: `[[Name of your pet (petname)]]`

To create a check box instead of a text input, annotate the label with `(?)`. This can be combined with a
field name annotation: `[[I agree to not be an idiot (notidiot?)]]`

A submit button can be created by naming a field "submit": `[[Apply now! (submit)]]`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rosuav/markdown_form.

Build and publish a gem with `rake build` and `rake release`.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
