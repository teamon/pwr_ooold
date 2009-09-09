class Images < Application
  
  before :ensure_authenticated
  before :ensure_lecture_author

  def index
    @images = @lecture.images.in_order
    display @images, :layout => false
  end

  def create(file)
    Image.create(:lecture => @lecture, :filedata => file)
    "1"
  end

  def update_positions(positions)
    positions.each_with_index do |id, index|
      @lecture.images.get(id).update(:position => index)
    end
    
    ""
  end

  def destroy(id)
    @image = Image.get(id) || (raise NotFound)
    if @image.destroy
      ""
    else
      raise InternalServerError
    end
  end
  
  protected 
  
  def ensure_lecture_author
    @lecture = Lecture.get(params[:lecture_id]) || (raise NotFound)
    raise Unauthorized unless @lecture.author?(session.user)
  end

end # Images
