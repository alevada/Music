require 'test_helper'

class ImportedVideosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @imported_video = imported_videos(:one)
  end

  test "should get index" do
    get videos_users_url
    assert_response :success
  end

  test "should get new" do
    get new_videos_user_url
    assert_response :success
  end

  test "should create imported_video" do
    assert_difference('ImportedVideo.count') do
      post videos_users_url, params: {imported_video: {imported_from_id: @imported_video.imported_from_id, user_id: @imported_video.user_id, video_id: @imported_video.video_id } }
    end

    assert_redirected_to videos_user_url(ImportedVideo.last)
  end

  test "should show imported_video" do
    get videos_user_url(@imported_video)
    assert_response :success
  end

  test "should get edit" do
    get edit_videos_user_url(@imported_video)
    assert_response :success
  end

  test "should update imported_video" do
    patch videos_user_url(@imported_video), params: {imported_video: {imported_from_id: @imported_video.imported_from_id, user_id: @imported_video.user_id, video_id: @imported_video.video_id } }
    assert_redirected_to videos_user_url(@imported_video)
  end

  test "should destroy imported_video" do
    assert_difference('ImportedVideo.count', -1) do
      delete videos_user_url(@imported_video)
    end

    assert_redirected_to videos_users_url
  end
end
