require 'rails_helper'

RSpec.describe Note, type: :model do
  # このファイルの全テストで使用するデータをセットする
  before do
    @user = User.create(
      first_name: "Jows",
      last_name: "Yamamoto",
      email: "jow@example.com",
      password: "111111",
    )

    @project = @user.projects.create(
      name: "Test Project",
    )
  end

  it "ユーザー、プロジェクト、メッセージがあれば有効な状態であること" do
    note = Note.new(
      message: "This is a sample note.",
      user: @user,
      project: @project,
    )
    expect(note).to be_valid
  end

  it "メッセージがなければ無効な状態であること" do
    note = Note.new(message: nil)
    note.valid?
    expect(note.errors[:message]).to include("can't be blank")
  end

  describe "文字列に一致するメッセージを検索する" do
    # 検索機能の全テストに関する追加のテストデータをセットする
    before do
      @note1 = @project.notes.create(
        message: "This is the first note.",
        user: @user,
      )
      @note2 = @project.notes.create(
        message: "This is the second note.",
        user: @user,
      )
      @note3 = @project.notes.create(
        message: "First, preheat oven.",
        user: @user,
      )
    end

    context "一致するデータが見つかるとき" do
      it "検索文字列に一致するメモを返すこと" do
        expect(Note.search("first")).to include(@note1, @note3)
      end
    end

    context "一致するデータが1件も見つからないとき" do
      it "空のコレクションを返すこと" do
        expect(Note.search("message")).to be_empty
      end
    end
  end
end