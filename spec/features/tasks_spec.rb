require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:project) {
    FactoryBot.create(:project,
      name: "RSpecチュートリアル",
      owner: user)
  }
  let!(:task) { project.tasks.create!(name: "RSpecチュートリアルを完了する") }

  scenario "ユーザーがタスクの状態を切り替える", js: true do
    # user = FactoryBot.create(:user)
    # project = FactoryBot.create(:project, name: "RSpecチュートリアル", owner: user)
    # task = project.tasks.create!(name: "RSpecチュートリアルを完了する")

    # visit root_path
    # click_link "Sign in"
    # fill_in "Email", with: user.email
    # fill_in "Password", with: user.password
    # click_button "Log in"

    # ヘルパーメソッドでDRYにする
    # sign_in_as user
    # Deviseのヘルパーメソッドを使う
    sign_in user
    # visit root_path

    # click_link "RSpecチュートリアル"
    # check "RSpecチュートリアルを完了する"

    # expect(page).to have_css "label#task_#{task.id}.completed"
    # expect(task.reload).to be_completed

    # uncheck "RSpecチュートリアルを完了する"

    # expect(page).to_not have_css "label#task_#{task.id}.completed"
    # expect(task.reload).to_not be_completed

    go_to_project "RSpecチュートリアル"

    complete_task "RSpecチュートリアルを完了する"
    expect_complete_task "RSpecチュートリアルを完了する"

    undo_complete_task "RSpecチュートリアルを完了する"
    expect_incomplete_task "RSpecチュートリアルを完了する"
  end

  def go_to_project(name)
    visit root_path
    click_link name
  end

  def complete_task(name)
    check name
  end

  def undo_complete_task(name)
    uncheck name
  end

  def expect_complete_task(name)
    aggregate_failures do
      expect(page).to have_css "label.completed", text: name
      expect(task.reload).to be_completed
    end
  end

  def expect_incomplete_task(name)
    aggregate_failures do
      expect(page).to_not have_css "label.completed", text: name
      expect(task.reload).to_not be_completed
    end
  end
end
