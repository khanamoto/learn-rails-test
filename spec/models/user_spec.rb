require 'rails_helper'

RSpec.describe User, type: :model do
  it "有効なファクトリを持つこと" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  # it "姓、名、メール、パスワードがあれば有効な状態であること" do
  #   user = User.new(
  #     first_name: "Taro",
  #     last_name: "Yamada",
  #     email: "test@example.com",
  #     password: "dottle"
  #   )
  #   expect(user).to be_valid
  # end

  # # is_expected で短く書いてみる
  # subject(:user) { FactoryBot.build(:user) }
  # it { is_expected.to satisfy { |user| user.name == "Poteto Head" } }

  # it "名がなければ無効な状態であること" do
  #   # user = User.new(first_name: nil)

  #   user = FactoryBot.build(:user, first_name: nil)

  #   user.valid?
  #   expect(user.errors[:first_name]).to include("can't be blank")
  # end

  # it "姓がなければ無効な状態であること" do
  #   # user = User.new(last_name: nil)

  #   user = FactoryBot.build(:user, last_name: nil)

  #   user.valid?
  #   expect(user.errors[:last_name]).to include("can't be blank")
  # end

  # it "メールアドレスがなければ無効な状態であること" do
  #   # user = User.new(email: nil)

  #   user = FactoryBot.build(:user, email: nil)

  #   user.valid?
  #   expect(user.errors[:email]).to include("can't be blank")
  # end

  # it "重複したメールアドレスなら無効な状態であること" do
  #   # User.create(
  #   #   first_name: "Bob",
  #   #   last_name: "Tanaka",
  #   #   email: "test@example.com",
  #   #   password: "nouveau",
  #   # )
  #   # user = User.new(
  #   #   first_name: "Tom",
  #   #   last_name: "Tanaka",
  #   #   email: "test@example.com",
  #   #   password: "tights",
  #   # )

  #   FactoryBot.create(:user, email: "aaa@example.com")
  #   user = FactoryBot.build(:user, email: "aaa@example.com")

  #   user.valid?
  #   expect(user.errors[:email]).to include("has already been taken")
  # end

  # 上記4つのテストをShoulda Matchersで短くする
  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_presence_of :last_name }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

  it "複数のユーザーでなにかする" do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user)
    expect(true).to be_truthy
  end

  it "ユーザーのフルネームを文字列として返すこと" do
    # user = User.new(
    #   first_name: "John",
    #   last_name: "Manjiro",
    #   email: "john@example.com",
    # )

    user = FactoryBot.build(:user, first_name: "John", last_name: "Manjiro")

    expect(user.name).to eq "John Manjiro"
  end
end
