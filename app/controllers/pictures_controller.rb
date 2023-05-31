class PicturesController < ApplicationController
  before_action :set_picture, only: [ :show, :edit, :update, :destroy ]

  def index
    @pictures = Picture.all
  end

  def show
  end

  def new
    @picture = Picture.new
  end

  def edit
  end

  def create
    @picture = Picture.new(picture_params)
    @picture = current_user.pictures.build(picture_params)

    respond_to do |format|
      if params[:back]
        render :new

      else
        if @picture.save
          format.json { render :show, status: :created, location: @picture }
          format.any  { render :new}
        else
          format.json { render json: @picture.errors, status: :unprocessable_entity }
          format.any  { render  :new}
        end
      end
    end
  end

  def confirm
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    render :new if @picture.invalid?
  end

  def update
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: "投稿が更新されました。"
    else
      render :edit
    end
  end

  def destroy
    @picture.destroy
      redirect_to pictures_path, notice: "投稿が削除されました。"
  end

  private

  def set_picture
    @picture = Picture.find(params[:id])
  end

  def picture_params
    params.require(:picture).permit(:image, :image_cache, :content)
  end

end