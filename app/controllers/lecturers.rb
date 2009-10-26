class Lecturers < Application
  provides :js

  def index(q = "")
    @lecturers = Lecturer.all(:name.like => "%#{q}%")
    display @lecturers
  end

end # Lecturers
