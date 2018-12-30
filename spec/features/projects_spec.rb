require 'rails_helper'

RSpec.feature "Projects", type: :feature do
  scenario "ユーザーは新しいプロジェクトを作成する" do
    user = FactoryBot.create(:user)

    # visit root_path
    # click_link "Sign in"
    # fill_in "Email", with: user.email
    # fill_in "Password", with: user.password
    # click_button "Log in"

    # ヘルパーメソッドでDRYにする
    # sign_in_as user
    # Deviseのヘルパーメソッドを使う
    sign_in user
    visit root_path

    expect {
      click_link "New Project"
      fill_in "Name", with: "テストプロジェクト"
      fill_in "Description", with: "Cabybaraを試す"
      click_button "Create Project"

      # expect(page).to have_content "Project was successfully created"
      # expect(page).to have_content "テストプロジェクト"
      # expect(page).to have_content "Owner: #{user.name}"
    }.to change(user.projects, :count).by(1)

    aggregate_failures do
      expect(page).to have_content "Project was successfully created"
      expect(page).to have_content "テストプロジェクト"
      expect(page).to have_content "Owner: #{user.name}"
    end
  end

  # ユーザーがログインしてないから失敗する
  # scenario "ゲストがプロジェクトを追加する" do
  #   visit projects_path
  #   # デバッグのためRailsがブラウザに返したHTMLを見る
  #   save_and_open_page
  #   click_link "New Project"
  # end
end
