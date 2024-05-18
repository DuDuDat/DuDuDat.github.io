module Jekyll
  module CollectionExtensions
    attr_accessor :subdir
  end
  class CollectionSubdirsGenerator < Generator
    safe true

    def generate(site)
      collections = []

      site.collections.each do |label, collection|
        collection_dir = File.join(site.source, collection.relative_directory) # _Develop
        next if collection.relative_directory == "_posts" # _posts 제외
        
        dirs = search_directories(collection_dir)

        dirs.each do |dir| # Language
          dir_path = File.join(collection_dir, dir)

          # 파일 경로 예시: _Develop/Language/C
          search_directories(dir_path).each do |sub_dir|
            set_docs(site, collection.docs, File.join(dir_path, sub_dir))
          end
          
          # 파일 경로 예시 _Develop/Error 모음
          set_docs(site, collection.docs, dir_path) # docs 정보
        end

        # 컬렉션 정보 저장
        if Dir.exist?(collection_dir) # collection_dir: D:/dududat.github.io/_Develop
          collection_dict = {
            "label" => collection.metadata["name"] || label, "dirs" => dirs, "img" => collection.metadata["img"]
          }
          collections << collection_dict
        end

        # 디렉토리 아이콘 등 저장
        json_file_path = File.join(site.source, 'directories_info.json')
        if File.exist?(json_file_path)
          json_data = File.read(json_file_path)
          json_data = JSON.parse(json_data)
          for dir_name, dics in json_data
            dics['name'] = dics.fetch('name', dir_name)
          end
          site.config['directories_info'] = json_data
        end
      end
      site.config['test'] = collections
    end

    # path: 디렉토리 경로, check: "dir" or "file" return sub_directories or sub_files
    def search_directories(path)
      sub_directories = []
      if Dir.exist?(path)
        Dir.foreach(path) do |entry|
          next if entry == '.' || entry == '..'
          full_path = File.join(path, entry)
          if File.directory?(full_path)
            sub_directories << entry
          end
        end
      end
      sub_directories
    end

    def set_docs(site, docs, path)
      return_docs = []
      val_path = path + "/"
      docs.each do |doc|
        if doc.path.split(val_path).last.include?("/")
          doc = { "url" => doc.url, "title" => doc.data['title'], "content" => doc.content }
          return_docs << doc
        end
      end
      site.config[path.split("/").last] = return_docs # 폴더명: documents 정보
    end



  end
end
