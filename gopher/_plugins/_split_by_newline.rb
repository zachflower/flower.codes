require 'liquid'
require 'uri'

module Jekyll
    module SplitByNewline
        def split_by_newline(input)
            return input.split("\n")
        end
    end
end

Liquid::Template.register_filter(Jekyll::SplitByNewline)