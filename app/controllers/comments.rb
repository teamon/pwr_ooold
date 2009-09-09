class Comments < Application
  # provides :xml, :yaml, :js
  
  before :ensure_authenticated

  # def index
  #   @comments = Comment.all
  #   display @comments
  # end

  # def show(id)
  #   @comment = Comment.get(id)
  #   raise NotFound unless @comment
  #   display @comment
  # end

  # def new
  #   only_provides :html
  #   @comment = Comment.new
  #   display @comment
  # end

  # def edit(id)
  #   only_provides :html
  #   @comment = Comment.get(id)
  #   raise NotFound unless @comment
  #   display @comment
  # end

  def create(comment)
    @lecture = Lecture.get(params[:lecture_id])
    raise NotFound unless @lecture
    @comment = @lecture.comments.new(comment)
    @comment.user = session.user
    if @comment.save
      redirect resource(@lecture), :message => "Komentarz został dodany"
    else
      @images = @lecture.images.in_order
      @comments = @lecture.comments.in_order
      render :template => 'lectures/show'
    end
  end

  # def update(id, comment)
  #   @comment = Comment.get(id)
  #   raise NotFound unless @comment
  #   if @comment.update(comment)
  #      redirect resource(@comment)
  #   else
  #     display @comment, :edit
  #   end
  # end

  # def destroy(id)
  #   @comment = Comment.get(id)
  #   raise NotFound unless @comment
  #   if @comment.destroy
  #     redirect resource(:comments)
  #   else
  #     raise InternalServerError
  #   end
  # end

end # Comments
