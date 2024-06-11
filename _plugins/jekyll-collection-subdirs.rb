require 'jekyll'
require 'json'
require 'open3'
require 'cgi'
require 'date'

module Jekyll
  module CollectionExtensions
    attr_accessor :subdir
  end
  class CollectionSubdirsGenerator < Jekyll::Generator
    safe true
    priority :high

    def generate(site)
      non_collection(site)
      custom_documents(site) # site.documents 객체 데이터 재정의
      document_size(site) # dir 에 속한 docs_size 정의

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

    # site.documents 객체 데이터 재정의
    def custom_documents(site, documents = site.documents)
      documents.each do |doc|
        file_creation_date = git_creation_date(doc.path)
        # if file_creation_date.nil?
        #   file_creation_date = File.mtime(doc.path)
        # end
        doc.data['created_date'] = file_creation_date
        doc.data['layout'] ||= 'post'
      end
      site.instance_variable_set(:@documents, documents)
    end

    # dir 에 속한 docs_size 정의
    def document_size(site, documents = site.documents)
      site.config["docs"] = {}
      total = []
      documents.each do |doc|
        total << {"url" => doc.url, "created_date" => doc.data['created_date'], "title" => doc.data['title']}
      end
      site.config["docs"]["total"] = total
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

    def git_creation_date(file_path)
      begin
        creation_date = `git log --diff-filter=A --follow --format=%aD -1 -- "#{file_path}"`.strip
        creation_date = creation_date.gsub(',', '')
        return Time.parse(creation_date) unless creation_date.empty?
      rescue => e
        puts "Error getting creation date for #{file_path}: #{e.message}"
      end
      File.mtime(file_path)
    end

    def non_collection(site)
      root_dir = ["personal", "team"]
      custom_collection = []

      site.pages.each do |post|
        dir = post.path.split("/").first
        if root_dir.include?(dir)
          post.data ||= {}
          post.data['layout'] ||= 'project'
          custom_collection << {
            'dir' => dir,
            'title' => post.name.split('.md').first,
            'content' => post.content,
            'url' => post.url.split('.html').first,
            'created_date' => git_creation_date(post.path),
            'label' => post.data['label'],
            'img' => post.data['img']
          }
        end
      end
      # site.instance_variable_set(:@pages, site.pages)
      site.config['project'] = custom_collection
    end

  end
end
