# frozen_string_literal: true

require_relative "markdown_form/version"

module Jekyll
  class MarkdownFormTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      text.strip!
      return if text == ""
      # Valid syntaxes:
      # {% field Thing %} -> input with name "thing" labelled "Thing"
      # {% field Your *name* %} -> input with name "name" labelled "Your name" - note that regular emphasis is thus disabled in labels
      # {% field Who are you? (name) %} -> input with name "name" labelled "Who are you?"
      # {% field I *agree* to the terms (?) %} -> check box with name "agree" labelled "I agree to the terms"
      # All above syntaxes can also be written as eg [[Thing]]
      # If the name is "submit", it will become a submit button.
      @name = ""
      @type = "text"
      @label = text.sub(/ *\(([A-Za-z0-9]*)(\??)\)$/) {|m|
        @name = $1
        @type = "checkbox" if $2 == "?"
        "" # Remove the parenthesized annotation
      }
      if @name == ""
        @label.sub!(/\*([A-Za-z0-9]+)\*/) {|m|
          @name = $1.downcase
          $1 # Remove the emphasis markers but keep the word (not downcased)
        }
      end
      # If a name hasn't been provided by annotation or emphasis, use the first word of the label.
      @name = /[^ ]+/.match(@label)[0].downcase if @name == ""
      if @name == "submit" then @type = "submit" end
    end

    def render(context)
      # Some names are magical and will change the rendering. Ideally this should be done in the
      # initialize method, but I don't know how to access site configs from there.
      if @name == context.registers[:site].config["form_scribble"] then @type = "scribble" end
      case @type
      when "checkbox" then "<label><input type=checkbox name=#{@name}> <span>#{@label}</span>"
      when "scribble" then "<label>#{@label}<br><canvas></canvas><input type=hidden name=#{@name}>"
      when "submit" then "<button type=submit>#{@label}</button>"
      else "<label><span>#{@label}</span> <input name=#{@name}></label>"
      end
    end
  end
end

Liquid::Template.register_tag('field', Jekyll::MarkdownFormTag)

Jekyll::Hooks.register [:pages, :documents], :pre_render do |doc, payload|
  # Translate [[blah]] syntax into {% field blah %}
  # The translation is applied ONLY if the page frontmatter includes "form: ..."
  # to provide additional information about the destination.
  if form = payload.page['form']
    doc.content.gsub!(/\[\[(.*?)\]\]/, '{% field \1 %}')
  end
end
