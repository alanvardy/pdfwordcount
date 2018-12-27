#!/usr/bin/env ruby
require 'pdf/reader' # gem install pdf-reader

# credits to :
#   https://gist.github.com/emad-elsaid/9722831
# 	https://github.com/yob/pdf-reader/blob/master/examples/text.rb
# usage example:
# 	ruby pdf2txt.rb /path-to-file/file1.pdf [/path-to-file/file2.pdf..]

ARGV.each do |filename|

  PDF::Reader.open(filename) do |reader|

    puts "Converting : #{filename}"
    pagenum = 0
    txt = reader.pages.map do |page|

      pagenum += 1
      begin
        print "Converting Page #{pagenum}/#{reader.page_count}\r"
        page.text
      rescue
        puts "Page #{pagenum}/#{reader.page_count} Failed to convert"
        ''
      end

    end # pages map

    filename = filename.scan(/\A(.+)\./)[0][0]
    puts "\nWriting #{filename}.txt to disk"
    newdoc = txt.join("\n")
    File.write filename + '.txt', newdoc
    words = txt.map { |line| line.split(' ').count }.sum
    lines = newdoc.scan(/\n(.+)\n/).count
    puts "Lines: #{lines}"
    puts "Words: #{words}"

	end # reader

end