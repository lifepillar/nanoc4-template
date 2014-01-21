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
