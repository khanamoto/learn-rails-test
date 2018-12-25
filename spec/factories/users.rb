FactoryBot.define do
  factory :user, aliases: [:owner] do
    # factory_bot 4.11で静的属性は非推奨のため、ブロックを使い動的属性にする
    first_name { "Poteto" }
    last_name { "Head" }
    sequence(:email) { |n| "testuser#{n}@example.com" }
    password { "abc123" }
  end
end
