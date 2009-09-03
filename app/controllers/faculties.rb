class Faculties < Application
  # provides :xml, :yaml, :js

  def index
    @faculties = Faculty.all(:order => [:id.asc])
    display @faculties
  end

  def show(id)
    @faculty = Faculty.get(id)
    raise NotFound unless @faculty
    display @faculty
  end

  def new
    only_provides :html
    @faculty = Faculty.new
    display @faculty
  end

  def edit(id)
    only_provides :html
    @faculty = Faculty.get(id)
    raise NotFound unless @faculty
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
    @faculty = Faculty.get(id)
    raise NotFound unless @faculty
    if @faculty.update_attributes(faculty)
       redirect resource(@faculty)
    else
      display @faculty, :edit
    end
  end

  def destroy(id)
    @faculty = Faculty.get(id)
    raise NotFound unless @faculty
    if @faculty.destroy
      redirect resource(:faculties)
    else
      raise InternalServerError
    end
  end

end # Faculties
