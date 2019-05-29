
class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]


  # GET /videos
  # GET /videos.json
  def index

    @videos = Video.search(params[:searchv])
    authorize! :read, Video
    # @videos = if current_user.role_id == 2
    #            Video.all
    #          else
    #            current_user.videos #.any? ? current_user.video : []
    #          end
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(video_params)
    @video.link_video = link_embed(@video.link_video)
    if @video.save
      flash[:success] = 'Video added!'
      redirect_to videos_path #root_url
    else
      render :new
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html {redirect_to @video, notice: 'Video was successfully updated.'}
        format.json {render :show, status: :ok, location: @video}
      else
        format.html {render :edit}
        format.json {render json: @video.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html {redirect_to videos_url, notice: 'Video was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_video
    @video = Video.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def video_params
    params.require(:video).permit(:name, :artist, :link_video, :searchv)
  end

  def link_embed(link_video)
    if link_video[/youtu\.be\/([^\?]*)/]
      youtube_id = $1
    else
      # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
      link_video[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      youtube_id = $5
    end

    "http://www.youtube.com/embed/#{ youtube_id }"
  end

end
