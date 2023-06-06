class WorkHoursController < ApplicationController
  # 一覧取得
  def index
    if params[:user_id]
      # クエリパラメータが指定されていれば絞り込み
      print(params[:user_id])
      @work_hours = WorkHour.where(user_id: params[:user_id])
    else
      # 無ければ全件取得
      @work_hours = WorkHour.all
    end
    render status: 200, json: { data: @work_hours, count: @work_hours.length }
  end

  def get_by_date
    @work_hour = WorkHour.find_by(user_id: params[:user_id], date: params[:date])

    render status: 200, json: @work_hour
  end

  # 新規登録
  def create
    @work_hour = WorkHour.new(work_hour_params)

    # save と save! の違い
    # 更新処理が失敗した場合に
    #   save:  falseを返す
    #   save!: 例外を発生
    @work_hour.save!
    result = {
      status: 0,
      data: @work_hour
    }
    render status: 201, json: result

  # rescue: 例外処理
  rescue Exception => e
    result = {
      status: 1,
      message: e.message
    }
    render status: 500, json: result
  end

  # 更新
  # user_id と date をキーにして検索する
  def update
    # body も querパラメータも "params[パラメータ名]" で取得できる
    @work_hour = WorkHour.find_by(user_id: params[:user_id], date: params[:date])

    # 更新対象が無ければエラーで終了
    if @work_hour.nil?
      render status: 500, json: { status: 1, message: 'not find' }
      return # returnを使うべきなのか、べスプラ調査
    end

    # 更新処理
    @work_hour.update!(work_hour_params_update)
    result = {
      status: 0,
      data: @work_hour
    }
    render status: 200, json: result
  rescue Exception => e
    result = {
      status: 1,
      message: e.message
    }
    render status: 500, json: result
  end

  # 削除
  def destroy
    @work_hour = WorkHour.find(params[:id])

    # 削除対象が無ければエラーで終了
    if @work_hour.nil?
      render status: 500, json: { status: 1, message: 'not find' }
      return
    end

    # 更新処理
    @work_hour.destroy!
    result = {
      status: 0
    }
    render status: 204, json: result
  rescue Exception => e
    result = {
      status: 1,
      message: e.message
    }
    render status: 500, json: result
  end

  # パラメータ
  private

  def work_hour_params
    params.permit(:user_id, :date, :start_time, :end_time)
  end

  def work_hour_params_update
    params.permit(:start_time, :end_time)
  end
end
