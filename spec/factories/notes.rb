FactoryBot.define do
  factory :note do
    message { "My important note." }
    association :project
    # association :user
    user { project.owner }

    # ファイルが最初から添付されたオブジェクトを作成する（ただしファクトリを使うたびに添付されてしまうため遅くなる原因になる可能性がある）
    trait :with_attachment do
      attachment { File.new("#{Rails.root}/spec/files/attachment.jpg") }
    end
  end
end
