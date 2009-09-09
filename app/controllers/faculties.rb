class Faculties < Application
  provides :xml
  
  def index
    @faculties = Faculty.all(:order => [:id.asc])
    @lectures = Lecture.recent.all(:limit => 10)
    @comments = Comment.recent.all(:limit => 10)
    display @faculties
  end

  # def show(code)
  #   @faculty = Faculty.first(:code => code)
  #   raise NotFound unless @faculty
  #   @lectures = @faculty.lectures.in_order.paginate(:page => params[:page], :per_page => 10)
  #   display @faculty
  # end

end # Faculties
