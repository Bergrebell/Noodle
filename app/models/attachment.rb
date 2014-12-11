class Attachment < ActiveRecord::Base
  belongs_to :task

  def uploaded_file(file, id)
    self.filename = file.original_filename
    self.content_type = file.content_type
    self.data = file.read
    self.task_id = id
  end

  def filename=(new_filename)
    write_attribute("filename", sanitize_filename(new_filename))
  end

  private
  def sanitize_filename(filename)
    #get only the filename, not the whole path (from IE)
    just_filename = File.basename(filename)
    #replace all non-alphanumeric, underscore or periods with underscores
    just_filename.gsub(/[^\w\.\-]/, '_')
  end
end
