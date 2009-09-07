class Lecturers < Application
  provides :js

  def index(q = "")
    @lecturers = Lecturer.all(:name.like => "%#{q}%")
    display @lecturers #.map{|e| e.name}.join("\n").to_s
  end

end # Lecturers
