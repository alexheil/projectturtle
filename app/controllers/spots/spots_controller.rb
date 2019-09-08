before_action :authenticate_user!, except: :show
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :set_user
  before_action :banned, except: [:show, :index]
  before_action :confirmed, except: [:show, :index]

  def show
    @owner = User.friendly.find(1)
    @spot = Spot.friendly.find(params[:id])
  end

  def new
    @spot = Spot.new
  end

  def create
    @spot = @user.spots.build(spot_params)
    if @spot.save
      flash[:notice] = "You just created " + @spot.title + "!"
      redirect_to user_spot_path(@user, @spot)
    else
      flash.now[:alert] = 'Whoa! Something went wrong!'
      render 'new'
    end
  end

  def edit
    @spot = Spot.friendly.find(params[:id])
  end

  def update
    @spot = Spot.friendly.find(params[:id])
    if @spot.update_attributes(spot_params)
      flash[:notice] = "Good job!"
      redirect_to user_spot_path(@user, @spot)
    else
      flash.now[:alert] = 'Bad job!'
      render 'edit'
    end
  end

  def destroy
    @spot = Spot.friendly.find(params[:id]).destroy
    redirect_to root_url
    flash[:notice] = "Delete successful."
  end

  private

    def set_user
      @user = current_user
    end

    def correct_user
      @owner = User.friendly.find(1)
      @spot = Spot.friendly.find(params[:id])
      @user = User.friendly.find(@spot.user_id)
      unless current_user == @user || current_user = @owner
        redirect_to root_url
      end
    end

    def confirmed
      @user = current_user
      if @user.confirmed_at.blank?
        redirect_to root_url
      end
    end

    def banned
      @user = current_user
      if @user.banned?
        redirect_to root_url
      end
    end

    def spot_params
      params.require(:spot).permit(:city_id, :title, :venue, :category, :description, :what_to_bring, :what_to_wear, :where_to_park, :website, :address, :start_hour, :start_minute, :end_hour, :end_minute, :month, :day, :year, :start_time, :end_time, :latitude, :longitude, :image, :remove_image, :spot_type, :start_am_pm, :end_am_pm, :sponsored, :street_number, :street_name, :city_name, :state_name, :country_name, :zip_code, :suite_number, :price)
    end

end