# frozen_string_literal: true

require_relative "markdown_form/version"

module Jekyll
  class MarkdownFormTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      text.strip!
      if m = text.match(/^([A-Za-z0-9]+)(\??): (.*)$/)
        @name = m[1]
        @type = m[2] == "?" ? "checkbox" : "text"
        @label = m[3]
      else
        @name = text.downcase
        @type = "text"
        @label = text
      end
      if @name == "submit" then @type = "submit" end
    end

    def render(context)
      case @type
      when "checkbox" then "<label><input type=checkbox name=#{@name}> #{@label}"
      when "submit" then "<button type=submit>#{@label}</button>"
      else "<label>#{@label}: <input name=#{@name}></label>"
      end
    end
  end
end

Liquid::Template.register_tag('form', Jekyll::MarkdownFormTag)
