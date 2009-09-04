class Lectures < Application
  # provides :xml, :yaml, :js
  
  before :ensure_authenticated, :exclude => [:index, :show]
  
  before do
    if params[:faculty_id]
      @faculty = Faculty.get(params[:faculty_id]) || (raise NotFound)
    end
  end
  
  def index
    @lectures = unless params[:query].blank?
      Lecture.all(:name.like => "%#{params[:query]}%")
    else
      Lecture
    end.in_order.paginate(:page => params[:page], :per_page => 10)
    display @lectures
  end

  def show(id)
    @lecture = get(id)
    @images = @lecture.images.in_order
    @comments = @lecture.comments.in_order
    @comment = @lecture.comments.new
    display @lecture
  end

  def new
    raise NotFound unless @faculty
    only_provides :html
    @lecture = Lecture.new
    display @lecture
  end

  def edit(id)
    @lecture = get(id)
    raise Unauthorized unless @lecture.author?(session.user)
    only_provides :html
    display @lecture
  end

  def create(lecture)
    raise NotFound unless @faculty
    @lecture = Lecture.new(lecture)
    @lecture.user = session.user
    @lecture.faculty = @faculty
    if @lecture.save
      redirect resource(@lecture, :edit), :message => "Wykład został dodany"
    else
      render :new
    end
  end

  def update(id, lecture)
    @lecture = get(id)
    raise Unauthorized unless @lecture.author?(session.user)
    if @lecture.update_attributes(lecture)
      redirect resource(@lecture, :edit), :message => "Zmiany zostały zapisane"
    else
      display @lecture, :edit
    end
  end

  def destroy(id)
    @lecture = get(id)
    raise Unauthorized unless @lecture.author?(session.user)
    if @lecture.destroy
      redirect resource(:lectures)
    else
      raise InternalServerError
    end
  end
  
  def package(id)
    @lecture = get(id)
    send_file *@lecture.package
  end
  
  protected
  
  def get(id)
    Lecture.get(id) || (raise NotFound)
  end

end # Lectures
