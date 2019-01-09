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

  scenario "ユーザーはプロジェクトを完了済みにする" do
    # プロジェクトを持ったユーザーを準備する
    user = FactoryBot.create(:user)
    project = FactoryBot.create(:project, owner: user)
    # ユーザーはログインしている
    # sign_in user
    login_as user, scope: :user

    # ユーザーがプロジェクト画面を開き
    visit project_path(project)

    expect(page).to_not have_content "完了済み"

    # "Complete"ボタンをクリックすると
    click_button "完了"

    # プロジェクトは完了済みとしてマークされる
    expect(project.reload.completed?).to be true
    expect(page).to have_content "おめでとう、このプロジェクトは完了しました！"
    expect(page).to have_content "完了済み"
    expect(page).to_not have_button "完了"
  end
end
