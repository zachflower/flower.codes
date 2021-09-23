require 'word_wrap'
require 'word_wrap/core_ext'

module Jekyll
  class PhlogPostConverter < Converter
    safe true
    priority :low

    def matches(ext)
      ext =~ /^\.txt$/i
    end

    def output_ext(ext)
      ".txt"
    end

    def convert(content)
      # capture links
      citations = content.scan(/\[\[([^\]]*)\]\]/)
      content.gsub!(/\[\[(.+)\]\]/i).with_index do |link, index|
        "[#{index}]"
      end

      # wrap to 68 characters
      content.wrap!(68)

      # trim trailing whitespace
      content.chomp!

      # append links as citations
      if citations.length > 0
        content << "\n\n"
        content << "---\n"
        citations.each_with_index do |citation, index|
          content << "[#{index}]: #{citation[0]}\n"
        end
        content << "---"
      end

      # return it all
      content
    end
  end
end