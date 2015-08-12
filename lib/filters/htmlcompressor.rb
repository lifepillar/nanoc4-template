class HtmlCompressorFilter < Nanoc::Filter
  identifier :htmlcompressor

  def run(content, params = {})
    Nanoc::External::Filter.new.run(
      content,
      params = {
        :exec => 'htmlcompressor',
        :options => %w(-t html)
      }
    )
  end
end

