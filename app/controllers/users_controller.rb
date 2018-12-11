class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
	if session['user']==0
		redirect_to({:controller => 'sessions', :action => 'new' }, notice:"已登出!"+session['user'].to_s)
    else
		@message="歡迎!"+session['user'].to_s
		@prm = User.find_by("name='#{session['user']}'")
		#顯示身分比自己低的與自己
		@users = User.where("permission<#{@prm.permission} or name='#{session['user']}'")
	end
  end

  # GET /users/1
  # GET /users/1.json
  def show
	#確認自己的權限
	@prm = User.find_by("name='#{session['user']}'")
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
	@ppp=""
	@repeat =User.where("name='#{@user[:name]}'")
	#密碼檢查
	checkpasswd=1
	user_params[:passwd].each_byte do |word|
        #數字
		if word<=39 &&word >=30
			checkpasswd*=2
		#英文
		elsif (word<=90 &&word >=65)||(word<=122 &&word >=97)
			checkpasswd*=3
		#其他符號
		else
			checkpasswd*=5
		end
	end
	respond_to do |format|
      #帳號已經被使用了
	  if @repeat.length>0
		format.html { redirect_to({:action =>:new}, notice:"ID名稱已經被使用了!")}
	  elsif checkpasswd%30!=0
		format.html { redirect_to({:action =>:new}, notice:"密碼至少要有一個數字、英文和特殊字元!"+checkpasswd.to_s)}
	  elsif user_params[:passwd].length<=8 || user_params[:passwd].length>=20
		format.html { redirect_to({:action =>:new}, notice:"密碼範圍要在8~20內")}
	  elsif @user.save
		if session['user']==0
			session['user']=user_params[:name]
		end
		format.html { redirect_to({:action =>:index}, notice:'註冊成功!')}
		#format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: '修改成功!' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: '刪除成功' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :passwd, :permission)
    end
end
