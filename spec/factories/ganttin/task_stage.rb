FactoryGirl.define do
  factory :task_stage, class: 'Ganttin::TaskStage' do
    task_id { create(:task).id }
    title { Faker::Lorem.sentence }
    duration { rand(24).hours }
    overdue { rand(10).hours * [1, -1].sample }
  end
end
