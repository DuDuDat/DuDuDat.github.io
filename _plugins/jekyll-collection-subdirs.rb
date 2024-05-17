module Jekyll
  module CollectionExtensions
    attr_accessor :subdir
  end
  class CollectionSubdirsGenerator < Generator
    safe true

    # def generate(site)
    #   # site.config['test'] = 'Hello, Jekyll!'
    #   values = []
    #
    #   site.collections.each do |label, collection|
    #
    #   end
    # end

    def generate(site)
      collections = []

      site.collections.each do |label, collection|
        collection_dir = File.join(site.source, collection.relative_directory)

        if Dir.exist?(collection_dir)
          subdirs = []

          Dir.foreach(collection_dir) do |entry|
            next if entry == '.' || entry == '..'
            full_path = File.join(collection_dir, entry)

            if File.directory?(full_path)
              puts "디렉토리임: #{entry}"
              subdirs << entry
            else
              puts "파일임 : #{entry}"
            end
          end

          dict = {
            "label" => collection.metadata["name"] || label, "subdirs" => subdirs,
          }
          collections << dict
        end
      end
      puts "#{collections}"
      site.config['test'] = collections
    end

  end
end
