FactoryGirl.define do
  factory :task, class: 'Ganttin::Task' do
    project_id { create(:project).id }
    body { Faker::Lorem.paragraph }
    title { Faker::Lorem.sentence }
    member_ids do
      Array.new(rand(10)) do
        create(:user).id
      end
    end
  end
end
