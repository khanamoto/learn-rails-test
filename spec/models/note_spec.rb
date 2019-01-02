require 'rails_helper'

RSpec.describe Note, type: :model do
  # このファイルの全テストで使用するデータをセットする
  # before do
  #   @user = User.create(
  #     first_name: "Jows",
  #     last_name: "Yamamoto",
  #     email: "jow@example.com",
  #     password: "111111",
  #   )

  #   @project = @user.projects.create(
  #     name: "Test Project",
  #   )
  # end

  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, owner: user) }

  # it "ファクトリで関連するデータを生成する" do
  #   note = FactoryBot.create(:note)
  #   puts "This note's project is #{note.project.inspect}"
  #   puts "This note's user is #{note.user.inspect}"
  # end

  it { is_expected.to have_attached_file(:attachment) }

  it "ユーザー、プロジェクト、メッセージがあれば有効な状態であること" do
    note = Note.new(
      message: "This is a sample note.",
      # user: @user,
      # project: @project,
      user: user,
      project: project,
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
    # before do
    #   @note1 = @project.notes.create(
    #     message: "This is the first note.",
    #     user: @user,
    #   )
    #   @note2 = @project.notes.create(
    #     message: "This is the second note.",
    #     user: @user,
    #   )
    #   @note3 = @project.notes.create(
    #     message: "First, preheat oven.",
    #     user: @user,
    #   )
    # end

    let!(:note1) {
      FactoryBot.create(:note,
        project: project,
        user: user,
        message: "This is the first note.",
      )
    }

    let!(:note2) {
      FactoryBot.create(:note,
        project: project,
        user: user,
        message: "This is the second note.",
      )
    }

    let!(:note3) {
      FactoryBot.create(:note,
        project: project,
        user: user,
        message: "First, preheat oven.",
      )
    }

    context "一致するデータが見つかるとき" do
      it "検索文字列に一致するメモを返すこと" do
        # expect(Note.search("first")).to include(@note1, @note3)
        expect(Note.search("first")).to include(note1, note3)
      end
    end

    context "一致するデータが1件も見つからないとき" do
      it "空のコレクションを返すこと" do
        # note1
        # note2
        # note3
        expect(Note.search("message")).to be_empty
        expect(Note.count).to eq 3
      end
    end
  end

  it "名前の取得をメモを作成したユーザーに委譲すること" do
    # user = FactoryBot.create(:user, first_name: "Fake", last_name: "User")
    # note = Note.new(user: user)

    # モックとスタブで置き換える
    user = double("user", name: "Fake User")
    note = Note.new
    allow(note).to receive(:user).and_return(user)

    expect(note.user_name).to eq "Fake User"
    # expect(note.user.first_name).to eq "Fake"
  end
end
