class Faculties < Application
  # provides :xml, :yaml, :js
  
  before :ensure_authenticated, :exclude => [:index, :show]

  def index
    @faculties = Faculty.all(:order => [:id.asc])
    @lectures = Lecture.recent
    display @faculties
  end

  def show(id)
    @faculty = get(id)
    @lectures = @faculty.lectures.in_order
    display @faculty
  end

  def new
    only_provides :html
    @faculty = Faculty.new
    display @faculty
  end

  def edit(id)
    only_provides :html
    @faculty = get(id)
    display @faculty
  end

  def create(faculty)
    @faculty = Faculty.new(faculty)
    if @faculty.save
      redirect resource(@faculty), :message => {:notice => "Faculty was successfully created"}
    else
      message[:error] = "Faculty failed to be created"
      render :new
    end
  end

  def update(id, faculty)
    @faculty = get(id)
    if @faculty.update_attributes(faculty)
       redirect resource(@faculty)
    else
      display @faculty, :edit
    end
  end

  def destroy(id)
    @faculty = get(id)
    if @faculty.destroy
      redirect resource(:faculties)
    else
      raise InternalServerError
    end
  end
  
  protected
  
  def get(id)
    Faculty.get(id) || (raise NotFound)
  end

end # Faculties
