module Jekyll
  class CollectionSubdirsGenerator < Generator
    safe true

    def generate(site)
      site.collections.each do |label, collection|
        collection_dir = File.join(site.source, collection.relative_directory)

        if Dir.exist?(collection_dir)
          subdirs = []

          Dir.foreach(collection_dir) do |entry|
            next if entry == '.' || entry == '..' # '.', '..' 제외
            full_path = File.join(collection_dir, entry)

            if File.directory?(full_path)
              puts "디렉토리임: #{entry}"
              subdirs << entry
            else
              puts "파일임 : #{entry}"
            end
          end

          # @subdirectories 인스턴스 변수 설정
          collection.instance_variable_set(:@subdirectories, subdirs)
        end
      end

      puts "Finished CollectionSubdirsGenerator"
    end
  end
end

module Jekyll
  module CollectionSubdirsFilter
    def subdirectories(collection)
      collection.instance_variable_get(:@subdirectories)
    end
  end
end

Liquid::Template.register_filter(Jekyll::CollectionSubdirsFilter)
