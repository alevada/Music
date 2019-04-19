
module ApplicationHelper
  def youtube_video(link_video)
    render :partial => 'shared/video', :locals => { :link_video => link_video }
  end
end
