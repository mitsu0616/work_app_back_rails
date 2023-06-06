require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET' do
    # describe の中でテストデータを生成しないとロールバックされない? 要調査
    before do
      FactoryBot.create(:user, :a)
      FactoryBot.create(:user, :b)
    end

    it 'GET /users 全件取得' do
      get '/users'
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).length).to eq(2)
    end

    it 'GET /user 対象メールアドレスのユーザー取得' do
      mail = 'tanaka@sample.com'
      get '/user?mail=' + mail
      expect(response).to have_http_status(200)
      hash = JSON.parse(response.body)
      expect(hash['mail']).to eq(mail)
    end
  end

  describe 'POST' do
    # 引数は"params:"で指定する
    params = {
      :name => "yamada",
      :mail => "yamada@sample.com"
    }
    it 'POST /users 新規ユーザー登録' do
      post '/users', params: params
      expect(response).to have_http_status(201) 
      get '/user?mail=' + params[:mail]
      expect(response).to have_http_status(200)
    end
  end
end
