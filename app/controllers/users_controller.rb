class UsersController < ApplicationController
  # 一覧取得
  def index
    @users = User.all
    render status: 200, json: @users
  end

  # id指定で取得
  def show
    @users = User.find(params[:id])
    render status: 200, json: @users
  end

  # 新規登録
  def create
    @user = User.new(user_params) # インスタンス化
    @user.save # 保存

    render status: 201, json: @user
  end

  ################################################################

  def test
    body = {
      id: 1,
      message: 'Hoge!'
    }

    response.set_header('X-Sample-Header', 'fuga')
    render status: 200, json: body
  end

  private
  # https://pikawaka.com/rails/permit
  def user_params
    params.permit(:name, :mail)
  end

end
