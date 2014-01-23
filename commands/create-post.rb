usage       'create-post <title>'
aliases     :post
summary     'Create a new blog post'
description 'Create a new blog post.'

option  :a, :author, 'Author name', :argument => :optional
option  :f, :filename, 'The filename (without suffix)'
flag    :m, :md,     'Append .md suffix (Markdown)'
flag    :M, :mmd,    'Append .mmd suffix (MultiMarkdown, default)'
flag    :h, :help,   'show help for this command' do |value, cmd|
  puts cmd.help
  exit 0
end

run do |opts, args, cmd|
  if args.empty?
    puts "Please specify a title."
    exit(1)
  end
  title = args.join(' ')
  author_line = opts[:author].nil? ? '' : "\nauthor_name: #{opts[:author]}"
  frontmatter = <<-FRONTMATTER
---
title:       #{title}#{author_line}
created_at:  #{Time.now}
tags:        []
kind:        article
---

Summary

<!-- more -->

Here we go!
FRONTMATTER
  suffix = opts[:md] ? 'md' : 'mmd'
  filename = title.downcase
  filename.gsub!(/\s+/, '-') # Replace spaces with dashes
  filename.gsub!(/--+/, '-') # Collapse dashes
  filename.gsub!(/[\\.!?;:#§*^"%$£&()\[\]{}]/, '')     # TODO: use a better method
  File.open("#{File.dirname(File.dirname(__FILE__))}/content/blog/posts/#{filename}.#{suffix}", 'w') do
    |f| f.write(frontmatter)
  end
end
