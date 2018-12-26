require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "#index" do
    it "正常にレスポンスを返すこと" do
      get :index
      # be_success は非推奨
      expect(response).to be_successful
    end

    it "200レスポンスを返すこと" do
      get :index
      expect(response).to have_http_status "200"
    end
  end
end
