require 'rails_helper'

RSpec.describe User, type: :model do
  it "姓、名、メール、パスワードがあれば有効な状態であること" do
    user = User.new(
      first_name: "Taro",
      last_name: "Yamada",
      email: "test@example.com",
      password: "dottle"
    )
    expect(user).to be_valid
  end

  it "名がなければ無効な状態であること" do
    user = User.new(first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  it "姓がなければ無効な状態であること" do
    user = User.new(last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  it "メールアドレスがなければ無効な状態であること" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "重複したメールアドレスなら無効な状態であること" do
    User.create(
      first_name: "Bob",
      last_name: "Tanaka",
      email: "test@example.com",
      password: "nouveau",
    )
    user = User.new(
      first_name: "Tom",
      last_name: "Tanaka",
      email: "test@example.com",
      password: "tights",
    )
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  it "ユーザーのフルネームを文字列として返すこと" do
  end
end
