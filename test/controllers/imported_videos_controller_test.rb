require 'test_helper'

class ImportedVideosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @imported_video = imported_videos(:one)
  end

  test "should get index" do
    get imported_videos_url
    assert_response :success
  end

  test "should get new" do
    get new_imported_video_url
    assert_response :success
  end

  test "should create imported_video" do
    assert_difference('ImportedVideo.count') do
      post imported_videos_url, params: { imported_video: { imported_from_id: @imported_video.imported_from_id, user_id: @imported_video.user_id, video_id: @imported_video.video_id } }
    end

    assert_redirected_to imported_video_url(ImportedVideo.last)
  end

  test "should show imported_video" do
    get imported_video_url(@imported_video)
    assert_response :success
  end

  test "should get edit" do
    get edit_imported_video_url(@imported_video)
    assert_response :success
  end

  test "should update imported_video" do
    patch imported_video_url(@imported_video), params: { imported_video: { imported_from_id: @imported_video.imported_from_id, user_id: @imported_video.user_id, video_id: @imported_video.video_id } }
    assert_redirected_to imported_video_url(@imported_video)
  end

  test "should destroy imported_video" do
    assert_difference('ImportedVideo.count', -1) do
      delete imported_video_url(@imported_video)
    end

    assert_redirected_to imported_videos_url
  end
end
