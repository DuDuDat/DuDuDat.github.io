require 'json'
require 'cgi'

module Jekyll
  module CollectionExtensions
    attr_accessor :subdir
  end
  class CollectionSubdirsGenerator < Generator
    safe true
    priority :high

    def generate(site)
      # site.documents 객체 데이터 재정의
      documents = site.documents
      documents.each do |doc|
        file_creation_date = File.birthtime(doc.path)
        doc.data['created_date'] = file_creation_date
        filename = File.basename(doc.basename, File.extname(doc.basename))
        doc.data['title'] ||= filename # 현재 title이 없는 경우에만 파일명을 title로 설정
        doc.data['layout'] ||= 'post'
      end
      site.instance_variable_set(:@documents, documents)

      # dir 에 속한 docs_size 정의
      site.config["docs"] = {}
      total = []
      documents.each do |doc|
        total << {"url" => doc.url, "created_date" => doc.data['created_date'], "title" => doc.data['title']}
      end
      site.config["docs"]["total"] = total

      site.config["dir"] = {}
      site.collections.each do |label, collection|
        collection_dir = File.join(site.source, collection.relative_directory) # _Develop
        next if label == "posts" # _posts 제외
        
        dirs = search_directories(site, collection_dir)

        dirs.each do |dir| # Language
          dir_path = File.join(collection_dir, dir)

          # 파일 경로 예시: _Develop/Language/C
          search_directories(site, dir_path).each do |sub_dir|
            set_docs(site, collection.docs, File.join(dir_path, sub_dir))
          end
          
          # 파일 경로 예시 _Develop/Error 모음
          set_docs(site, collection.docs, dir_path) # docs 정보
        end
      end
    end

    # path: 디렉토리 경로, 디렉토리 정보 sub 디렉토리, 아이콘
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
      json_file_path = File.join(site.source, 'directory_info.json')
      root_dir = path.split("/").last
      sub_dirs = []
      if File.exist?(json_file_path)
        json_data = File.read(json_file_path)
        json_data = JSON.parse(json_data)
        sub_directories.each do |dir|
          sub_dirs << {dir => json_data[dir]}
        end
      end
      site.config["dir"][root_dir] = sub_dirs
      sub_directories
    end

    def set_docs(site, docs, path)
      documents = []
      val_path = path + "/"
      docs.each do |doc|
        if doc.path.include?(val_path)
          documents << {"url" => doc.url, "created_date" => doc.data['created_date'], "title" => doc.data['title']}
        end
      end
      site.config["docs"][path.split("/").last] = documents # 폴더명: documents 정보
    end



  end
end
