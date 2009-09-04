class Faculties < Application
  # provides :xml, :yaml, :js
  
  def index
    @faculties = Faculty.all(:order => [:id.asc])
    @lectures = Lecture.recent
    display @faculties
  end

  def show(id)
    @faculty = Faculty.get(id)
    raise NotFound unless @faculty
    @lectures = @faculty.lectures.in_order
    display @faculty
  end

end # Faculties
