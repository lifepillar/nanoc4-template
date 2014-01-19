class MarkdownCodeFenceColorize < Nanoc::Filter
  identifier :markdown_code_fence_colorize_adapter

  def run(content, params={})
    content.gsub(/```(?<lang>.+)/, '```language-\k<lang>')
  end
end
