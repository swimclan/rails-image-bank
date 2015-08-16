class ImagesController < ApplicationController
  # put a login wall around all of the views governed by this controller
  before_filter :authorize

  def index
    # Go get all the images from the database
    current_user_images = Image.all.where(:user_id => current_user)
    if current_user_images.count < 1
      @modify = false
      @images = Image.all
      @message = 'Images from all users'
    else
      @modify = true
      @images = current_user_images
      @message = 'Your images'
    end
  end

  def new
    # display the form to add a new image to the user

  end

  def create
    # dump the new image data into the database
    puts '----------------------'
    puts params
    puts '----------------------'
    @image = Image.new(image_params)
    @image.save
    redirect_to '/'
  end

  def edit
    # render the edit form
    #get the image to edit
    @image = Image.find(params[:image][:id])
  end

  def update
    # process the edit and save into the database
    @image = Image.find(params[:image][:id])

    @image.update(:title => params[:image][:title], :url => params[:image][:url], :description => params[:image][:description])
    @message = "Image updated"
    redirect_to '/'
  end

  def delete
    @image = Image.find(params[:image][:id])
    @image.destroy
  end

  #private methods for the images controller class (no one on the outside has access to this class)
  private

  def image_params
    params.require(:image).permit(:title, :url, :description, :user_id)
  end


end
