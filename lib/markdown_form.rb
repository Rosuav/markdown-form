# frozen_string_literal: true

require_relative "markdown_form/version"

module Jekyll
  class MarkdownFormTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @text = text
      puts "Hello, world!"
    end

    def render(context)
      "<input> #{@text}"
    end
  end
end

Liquid::Template.register_tag('form', Jekyll::MarkdownFormTag)
