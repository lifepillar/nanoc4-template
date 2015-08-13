module BloggingExtensions

  # Returns a hash whose keys are [year,month] pairs and whose values
  # are the articles created in the corresponding period.
  # From http://stackoverflow.com/questions/9538863/using-nanoc-to-create-a-list-of-blog-articles-sorted-by-month-and-year
  def grouped_articles
    sorted_articles.group_by do |a|
      [ a[:created_at].year, a[:created_at].month ]
    end.sort.reverse
  end

  # Returns the summary for an item (typically, a blog post). The summary is
  # determined as follows: if the item has an 'excerpt' attribute in the
  # frontmatter, the value of that attribute is used; otherwise, if the item
  # has a '<!-- more -->' separator, the text before the separator is returned;
  # otherwise, the empty string is returned.
  #
  # NOTE: this may not work if a filter that strips HTML comments is used
  # (in such a case, the excerpt attribute should be used).
  def summary(article)
    return '<p>' + article[:excerpt] + '</p>' if article.key?(:excerpt)
    content = article.compiled_content(:snapshot => :pre)
    if content =~ /\s<!-- more -->\s/
      return content.partition('<!-- more -->').first
    else
      return ""
    end
  end

  # Returns a hash of all the tags associated with the given set of items in
  # which each key is a tag and the corresponding value denotes the number of
  # items tagged with that tag.
  def all_tags(item_set)
    tags = {}
    item_set.each do |i|
      i.fetch(:tags, []).each { |t| tags[t] = tags.fetch(t, 0) + 1 }
    end
    tags
  end

  # Creates a page for each tag appearing in the given set of items.
  def build_tag_pages(item_set)
    all_tags(item_set).each do |tag, count|
      @items.create(
        "<%= render '/blog/tag.erb', :tag => '#{tag}' %>",
        {:title => "Articles tagged ‘#{tag}’", :kind => 'tag-page', :tag => tag, :count => count},
        "/blog/tags/#{tag}.erb",
        :binary => false
      )
    end
  end

  # Returns an array of items for the given year and, optionally, the given month.
  # The month must be an integer in [1..12].
  def items_for_period(item_set, year, month = nil)
    item_set.select do |i|
      i[:created_at].year == year && (month.nil? ? true : i[:created_at].month == month)
    end
  end

  # Builds lists of items by year and month.
  def build_archives(item_set)
    item_set.group_by { |a| a[:created_at].year }.each do |year, year_articles|
      @items.create(
        # TODO: is there a way to pass year_articles to the item?
        # As a page attribute, it does not work.
        # As an argument to render, it produces an error.
        "<%= render '/blog/archive.*' %>",
        {:title => "Articles from #{year}", :year => year, :month => nil},
        "/blog/archives/#{year}.erb",
        :binary => false
      )
      year_articles.group_by { |a| a[:created_at].month }.each do |month, month_articles|
        @items.create(
          "<%= render '/blog/archive.*' %>",
          {:title => "Articles from #{Date::MONTHNAMES[month]} #{year}", :year => year, :month => month},
          "/blog/archives/#{year}/#{Date::ABBR_MONTHNAMES[month]}.erb",
          :binary => false
        )
      end
    end
  end
end # module

