class UsersController <ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to users_path
    else
      render 'new'
  end
end

  def show
    @user = User.find params[:id]
  end

  def high_scores
    @scores = Score.all.group_by(&:user).map { |k,v| v.first }.sort{|x,y|y.value<=>x.value}
  end
end