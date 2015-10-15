class PhotosController < ApplicationController

  respond_to :json

def create
  @photo = Photo.new(whitelisted_photo_params)
  @photo.profile_id = current_user.profile.id
  if @photo.save!
    render json: @photo.to_json(methods: :picture_url)
  else
    render nothing: true, status: 404
  end
end

def update
  @photo = Photo.find(params[:id])
  if @photo.update(whitelisted_photo_params)
    render json: @photo.to_json(methods: :picture_url)
  else
    render nothing: true, status: 404
  end
end

private

def whitelisted_photo_params
  params.require(:photos).permit(:picture)
end

end