module BloggingExtensions

  # From http://stackoverflow.com/questions/9538863/using-nanoc-to-create-a-list-of-blog-articles-sorted-by-month-and-year
  def grouped_articles
    sorted_articles.group_by do |a|
      [ a[:created_at].year, a[:created_at].month ]
    end.sort.reverse
  end

  # Returns the summary for an item (typically, a blog post).
  # The summary is determined as follows: if the item has an 'excerpt' attribute
  # in the frontmatter, the value of that attribute is used; otherwise, if the
  # item has a '<!-- more -->' separator, the text before the separator is
  # returned; otherwise, the empty string is returned.
  def summary(item)
    return item[:excerpt] unless item[:excerpt].nil?
    content = item.compiled_content
    if content =~ /\s<!-- more -->\s/
      return content.partition('<!-- more -->').first
    else
      return ""
    end
  end

  def all_tags(items_set= nil, sort = false)
    items_set ||= @items # default to all items if no items passed
    tags = {}
    items_set.each do |i|
      (i[:tags] || []).each{ |t| tags[t] ||= 0; tags[t] += 1 }
    end
    # if sort is true, sort by item count descending
    sort ? tags.sort{ |tl, tr| tr[1] <=> tl[1] } : tags
  end

  def build_tag_pages(items_set)
    all_tags(items_set, true).each do |tag,count|
      @items << Nanoc::Item.new(
        "<%= render 'blog/tag', :tag => '#{tag}' %>",
        {:title => 'Articles tagged ‘#{tag}’', :tag => tag, :count => count},
        "/blog/tags/#{tag}/",
        :binary => false
      )
    end
  end

  # Returns an array of items for the given year and, optionally, the given month.
  # The month must be an integer in [1..12].
  def items_for_period(items_set, year, month = nil)
    items_set.select { |i| i[:created_at].year == year && (month.nil? ? true : i[:created_at].month == month)}
  end

  # Builds lists of items by year and month.
  def build_archives(items_set)
    items_set.group_by { |a| a[:created_at].year }.each do |year, year_articles|
      @items << Nanoc::Item.new(
        # TODO: is there a way to pass year_articles to the item?
        # As a page attribute, it does not work.
        # As an argument to render, it produces an error.
        "<%= render '/blog/archive' %>", # page
        {:title => "Articles from #{year}", :year => year, :month => nil}, # page attributes
        "/blog/archives/#{year}/", # path
        :binary => false
      )
      year_articles.group_by { |a| a[:created_at].month }.each do |month, month_articles|
        @items << Nanoc::Item.new(
          "<%= render '/blog/archive' %>", # page
          {:title => "Articles from #{Date::MONTHNAMES[month]} #{year}", :year => year, :month => month}, # page attributes
          "/blog/archives/#{year}/#{Date::ABBR_MONTHNAMES[month]}", # path
          :binary => false
        )
      end
    end
  end
end # module
