module Jekyll
  class CollectionSubdirsGenerator < Generator
    safe true

    def generate(site)
      site.collections.each do |label, collection|
        puts "오옹: #{label}"

        collection_dir = File.join(site.source, collection.relative_directory)

        if Dir.exist?(collection_dir)
          subdirs = Dir.entries(collection_dir).select do |entry|
            path = File.join(collection_dir, entry)
            puts "오옹: #{path}"
            File.directory?(path) && !(entry == '.' || entry == '..')
          end
        end
        collection.docs.each do |doc|
          doc_dir = File.dirname(doc.path)
          puts "에옹 #{doc_dir}"
          parent_dir = File.expand_path(doc_dir, site.source)  # 절대 경로로 변환

          puts "Processing document in directory: #{parent_dir}"

          if Dir.exist?(parent_dir)
            subdirs = Dir.entries(parent_dir).select do |entry|
              File.directory?(File.join(parent_dir, entry)) && !(entry == '.' || entry == '..')
            end
            puts "Subdirectories: #{subdirs.join(', ')}"
          else
            puts "Directory does not exist: #{parent_dir}"
          end
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
