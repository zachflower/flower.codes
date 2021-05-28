# frozen-string-literal: true

Jekyll::External.require_with_graceful_fail "commonmarker"

module Jekyll
  module Converters
    class Markdown
      class UncommonMark
        DEFAULT_CONFIG = { "extensions" => [], "options" => [] }.freeze
        PARSE_KEYS = CommonMarker::Config::Parse.keys
        RENDER_KEYS = CommonMarker::Config::Render.keys
        VALID_EXTENSIONS = CommonMarker.extensions.collect(&:to_sym)
        VALID_OPTIONS = (PARSE_KEYS + RENDER_KEYS).uniq

        private_constant :DEFAULT_CONFIG, :PARSE_KEYS, :RENDER_KEYS,
                         :VALID_EXTENSIONS, :VALID_OPTIONS

        def initialize(config)
          @config = config["uncommonmark"] || DEFAULT_CONFIG

          @parse_options = options & PARSE_KEYS
          @render_options = options & RENDER_KEYS

          @parse_options = :DEFAULT if @parse_options.empty?
          @render_options = :DEFAULT if @render_options.empty?
        end

        def convert(content)
          HtmlRenderer.new(
            :options    => render_options,
            :extensions => extensions
          ).render(
            CommonMarker.render_doc(content, parse_options, extensions)
          )
        end

        private

        attr_reader :config, :parse_options, :render_options

        def extensions
          @extensions ||= prepare("extensions", ->(item) { item.to_sym }, VALID_EXTENSIONS)
        end

        def options
          @options ||= prepare("options", ->(item) { item.upcase.to_sym }, VALID_OPTIONS)
        end

        def prepare(key, proc, valid_keys)
          collection = config[key].map(&proc)
          validate(collection, valid_keys, key[0..-2])
        end

        def validate(list, bucket, type)
          list.reject do |item|
            next if bucket.include?(item)

            Jekyll.logger.warn "UncommonMark:", "#{item} is not a valid #{type}"
            Jekyll.logger.info "Valid #{type}s:", bucket.join(", ")
            true
          end
        end
      end
    end
  end
end


module Jekyll
  module Converters
    class Markdown
      class UncommonMark
        class HtmlRenderer < CommonMarker::HtmlRenderer
          def code_block(node)
            block do
              lang = extract_code_lang(node.fence_info)

              out("<font color=\"green\"><pre", sourcepos(node))

              if option_enabled?(:GITHUB_PRE_LANG)
                out_data_attr(lang)
                out("><code>")
              else
                out("><code")
                out_data_attr(lang)
                out(">")
              end
              out(render_with_rouge(node.string_content, lang))
              out("</code></pre></font>")
            end
          end

          def paragraph(node)
            align = 'justify'

            if @in_tight && node.parent.type != :blockquote
              out(:children)
            else
              block do
                container("<p#{sourcepos(node)} align=\"#{align}\">", '</p>') do
                  out(:children)
                  if node.parent.type == :footnote_definition && node.next.nil?
                    out(' ')
                    out_footnote_backref
                  end
                end
              end
            end
          end

          def blockquote(node)
            block do
              container("<blockquote#{sourcepos(node)}><font color=\"gray\"><em>\n", '</em></font></blockquote>') do
                out(:children)
              end
            end
          end

          def image(node)
            width = 800

            filename = node.url

            if filename.start_with?('/assets/posts/')
              filename = filename.sub(".png", "-degraded.png") if filename.end_with?(".png")
              filename = filename.sub(".jpg", "-degraded.jpg") if filename.end_with?(".jpg")
            end

            out('<center>')
            out('<img src="', escape_href(filename), '"')
            plain do
              out(' alt="', :children, '"')
            end
            out(' title="', escape_html(node.title), '"') if node.title && !node.title.empty?
            out(" width=\"#{width}\" />")
            out('</center>')
          end

          def hrule(node)
            block do
              out("<hr#{sourcepos(node)} size=\"1\" noshade />")
            end
          end

          private

          def extract_code_lang(info)
            return unless info.is_a?(String)
            return if info.empty?

            info.split(%r!\s+!)[0]
          end

          def out_data_attr(lang)
            return unless lang

            out(' data-lang="', lang, '"')
          end

          def render_with_rouge(code, lang)
            require "rouge"

            formatter = Rouge::Formatters::HTMLLegacy.new(
              :line_numbers => false,
              :wrap         => false,
              :css_class    => "highlight",
              :gutter_class => "gutter",
              :code_class   => "code"
            )
            lexer = Rouge::Lexer.find_fancy(lang, code) || Rouge::Lexers::PlainText
            formatter.format(lexer.lex(code))
          end
        end
      end
    end
  end
end
