class SessionsController < ApplicationController
  def new
	#第一次登入
	if session['first']!=0
		session['first']=0
		session['user']=0
	end
	#如果登入跳轉
	if session['user']!=0
		redirect_to({:controller => 'users', :action => 'index' }, notice:"歡迎!"+session['user'].to_s)
	end
  end
  def create
	
	cmd = "name='#{params[:session][:name]}' and passwd='#{params[:session][:passwd]}'"
	@ans = User.where(cmd)
	if @ans.length==0
		redirect_to({:action =>:new}, notice:"帳號密碼錯誤!"+session['user'].to_s)
	elsif verify_recaptcha(model: @ans)
		redirect_to({:action =>:new}, notice:"請驗證!"+session['user'].to_s)
	else
		session['user']=params[:session][:name]
		redirect_to ({:controller => 'users', :action => 'index' })
		
	end
  end
  def destory
	session['user']=0
	redirect_to ({:controller => 'sessions', :action => 'new' })
  end
   private
  def guests_params
	params.permit(:name, :passwd)
  end
end
