class MultiMarkdownFilter < Nanoc::Filter
  identifier :multimarkdown
  type :text
  @@debug = false

  # Executes this filter. This params argument accepts the following keys:
  #
  # :path   Path to the directory containing the MultiMarkdown executable.
  #         Use this if multimarkdown is not in your PATH.
  # :debug  Set to true to enable debugging.
  #
  # All other keys are parsed and passed to multimarkdown.
  def run(content, params = {})
    @@debug = params.delete(:debug) { false }
    mm = params.delete(:path)  { nil }
    mm = mm.nil? ? 'multimarkdown' : File.join(mm, 'multimarkdown')
    opts = parseOptions(params)
    cmd = mm + ' ' + opts.join(' ')
    odebug(cmd)
    out = ''
    IO.popen(cmd, mode='r+') do |io|
      io.write content
      io.close_write # let the process know you've given it all the data
      out = io.read
    end
    odebug(out)
    out
  end

  def parseOptions(params)
    opts = []
    snippet = true
    params.each do |key,value|
      case key
      when :to
        # Validate value
        if value.match(/^[a-z]+$/).nil?
          puts "\033[1;35mWarn:\033[0m Invalid output format: #{value}"
        else
          opts << "--to=#{value}"
        end
      when :compatibility
        opts << '--compatibility' if value
      when :snippet
        snippet = value
      when :process_html
        opts << '--process-html' if value
      when :random
        opts << '--random' if value
      when :accept
        opts << '--accept' if value
      when :reject
        opts << '--reject' if value
      when :smart
        opts << (value ? '--smart' : '--nosmart')
      when :notes
        opts << (value ? '--notes' : '--nonotes')
      when :labels
        opts << (value ? '--labels' : '--nolabels')
      when :mask
        opts << (value ? '--mask' : '--nomask')
      when :batch
        opts << '--batch' if value
      when :full
        opts << '--full' if value
      else
        puts "\033[1;35mWarn:\033[0m Unknown MultiMarkdown option: #{key}"
      end
    end
    opts << '--snippet' if snippet
    opts
  end

  def odebug(msg)
    msg.each_line { |l| puts "\033[1;31mDEBUG:\033[0m #{l}" } if @@debug
  end

end # MultiMarkdownFilter
