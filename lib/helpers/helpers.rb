include Nanoc::Helpers::Blogging
include Nanoc::Helpers::Tagging
include Nanoc::Helpers::Rendering
include Nanoc::Helpers::LinkTo
include Nanoc::Helpers::XMLSitemap

# From http://stackoverflow.com/questions/9538863/using-nanoc-to-create-a-list-of-blog-articles-sorted-by-month-and-year
def grouped_articles
  sorted_articles.group_by do |a|
    [ a[:created_at].year, a[:created_at].month ]
  end.sort.reverse
end
