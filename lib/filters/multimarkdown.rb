# encoding: utf-8 

module Nanoc::Filters
  class MultiMarkdownFilter < Nanoc::Filter
    identifier :multimarkdown
    type :text

    # Executes this filter. Parameters passed to this filter through `:opts`
    # will be passed to MultiMarkdown.
    #
    # @param [String] content The content to filter.
    #
    # @option params [Symbol] :opts ([]) A list of options for Multimarkdown.
    #  Example: opts: %w( --compatibility --to=latex --smart )
    #
    # @option params [Symbol] :path ("") The path to the directory containing 
    #   the `multimarkdown` executable. Use this when the executable is not in
    #   your PATH.
    #
    # @option params [Symbol] :debug (false) Set to true to enable debugging.
    #
    # @return [String] The filtered content
    def run(content, params = {})
      filter = Nanoc::Filter.named(:external).new(assigns)
      filter.run(content, params.merge({ exec: 'multimarkdown' }))
    end
  end
end
