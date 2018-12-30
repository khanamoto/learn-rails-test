require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  scenario "ユーザーがタスクの状態を切り替える", js: true do
    user = FactoryBot.create(:user)
    project = FactoryBot.create(:project, name: "RSpecチュートリアル", owner: user)
    task = project.tasks.create!(name: "RSpecチュートリアルを完了する")

    # visit root_path
    # click_link "Sign in"
    # fill_in "Email", with: user.email
    # fill_in "Password", with: user.password
    # click_button "Log in"

    # ヘルパーメソッドでDRYにする
    sign_in_as user

    click_link "RSpecチュートリアル"
    check "RSpecチュートリアルを完了する"

    expect(page).to have_css "label#task_#{task.id}.completed"
    expect(task.reload).to be_completed

    uncheck "RSpecチュートリアルを完了する"

    expect(page).to_not have_css "label#task_#{task.id}.completed"
    expect(task.reload).to_not be_completed
  end
end
