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
end # module
