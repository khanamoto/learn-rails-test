require 'rails_helper'

RSpec.describe Note, type: :model do
  it "検索文字列に一致するメモを返すこと" do
    user = User.create(
      first_name: "Jow",
      last_name: "Yamamoto",
      email: "jow@example.com",
      password: "111111",
    )

    project = user.projects.create(
      name: "Test Project",
    )

    note1 = project.notes.create(
      message: "This is the first note.",
      user: user,
    )
    note2 = project.notes.create(
      message: "This is the second note.",
      user: user,
    )
    note3 = project.notes.create(
      message: "First, preheat the oven.",
      user: user,
    )

    expect(Note.search("first")).to include(note1, note3)
    expect(Note.search("first")).to_not include(note2)
  end

  it "検索結果が1件も見つからなければ空のコレクションを返すこと" do
    user = User.create(
      first_name: "Mike",
      last_name: "Banana",
      email: "test@example.com",
      password: "000000",
    )

    project = user.projects.create(
      name: "Test Project",
    )

    note1 = project.notes.create(
      message: "This is the first note.",
      user: user,
    )
    note2 = project.notes.create(
      message: "This is the second note.",
      user: user,
    )
    note3 = project.notes.create(
      message: "First, preheat oven.",
      user: user,
    )

    expect(Note.search("message")).to be_empty
  end
end
