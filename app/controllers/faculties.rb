class Faculties < Application
  # provides :xml, :yaml, :js
  
  def index
    @faculties = Faculty.all(:order => [:id.asc])
    @lectures = Lecture.recent(:limit => 10)
    display @faculties
  end

  def show(id)
    @faculty = Faculty.get(id)
    raise NotFound unless @faculty
    @lectures = @faculty.lectures.in_order.paginate(:page => params[:page], :per_page => 10)
    display @faculty
  end

end # Faculties
