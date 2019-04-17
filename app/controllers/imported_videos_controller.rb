class ImportedVideosController < ApplicationController
  before_action :set_imported_video, only: [:show, :edit, :update, :destroy]

  # GET /imported_videos
  # GET /imported_videos.json
  def index
    @imported_videos = ImportedVideo.all
  end

  # GET /imported_videos/1
  # GET /imported_videos/1.json
  def show
  end

  # GET /imported_videos/new
  def new
    @imported_video = ImportedVideo.new
  end

  # GET /imported_videos/1/edit
  def edit
  end

  # POST /imported_videos
  # POST /imported_videos.json
  def create
    @imported_video = ImportedVideo.new(imported_video_params)

    respond_to do |format|
      if @imported_video.save
        format.html { redirect_to @imported_video, notice: 'Imported video was successfully created.' }
        format.json { render :show, status: :created, location: @imported_video }
      else
        format.html { render :new }
        format.json { render json: @imported_video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /imported_videos/1
  # PATCH/PUT /imported_videos/1.json
  def update
    respond_to do |format|
      if @imported_video.update(imported_video_params)
        format.html { redirect_to @imported_video, notice: 'Imported video was successfully updated.' }
        format.json { render :show, status: :ok, location: @imported_video }
      else
        format.html { render :edit }
        format.json { render json: @imported_video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /imported_videos/1
  # DELETE /imported_videos/1.json
  def destroy
    @imported_video.destroy
    respond_to do |format|
      format.html { redirect_to imported_videos_url, notice: 'Imported video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_imported_video
      @imported_video = ImportedVideo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def imported_video_params
      params.require(:imported_video).permit(:user_id, :video_id, :imported_from_id)
    end
end
