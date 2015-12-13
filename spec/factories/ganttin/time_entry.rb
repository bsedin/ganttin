FactoryGirl.define do
  factory :time_entry, class: 'Ganttin::TimeEntry' do
    task_id { create(:task).id }
    user_id { create(:user).id }
    project_id { create(:project).id }
    duration { rand(1..24).hours }
    body { Faker::Lorem.sentence }
  end
end
