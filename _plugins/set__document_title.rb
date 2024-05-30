Jekyll::Hooks.register :documents, :pre_render do |doc|
  filename = File.basename(doc.basename, File.extname(doc.basename))
  doc.data['title'] = filename
end
