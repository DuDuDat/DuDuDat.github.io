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
        next if label == "posts" # _posts 제외

        directories_info = {}
        
        dirs, dir_data = search_directories(site, collection_dir)
        directories_info = directories_info.merge(dir_data)

        dirs.each do |dir| # Language
          dir_path = File.join(collection_dir, dir)

          # 파일 경로 예시: _Develop/Language/C
          sub_dirs, sub_dir_data = search_directories(site, dir_path)
          directories_info = directories_info.merge(sub_dir_data)

          sub_dirs.each do |sub_dir|
            set_docs(site, collection.docs, File.join(dir_path, sub_dir))
          end
          
          # 파일 경로 예시 _Develop/Error 모음
          set_docs(site, collection.docs, dir_path) # docs 정보
        end

        # 컬렉션 정보 저장
        if Dir.exist?(collection_dir) # collection_dir: D:/dududat.github.io/_Develop
          collection_dict = {
            "label" => collection.metadata["name"] || label, "dirs" => directories_info, "img" => collection.metadata["img"]
          }
          collections << collection_dict
        end


      end
      site.config['cols'] = collections
    end

    # path: 디렉토리 경로, check: "dir" or "file" return sub_directories or sub_files
    def search_directories(site, path)
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
      # 디렉토리 아이콘 등 저장
      json_file_path = File.join(site.source, 'directories_info.json')
      root_dir = path.split("/").last
      root_dir = root_dir.sub(/^_/, '')
      sub_dirs = []
      if File.exist?(json_file_path)
        json_data = File.read(json_file_path)
        json_data = JSON.parse(json_data)
        sub_directories.each do |dir|
          sub_dirs << {dir => json_data[dir] || {}}
        end
      end
      data = {root_dir => sub_dirs}
      [sub_directories, data]
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
