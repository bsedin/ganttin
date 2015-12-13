FactoryGirl.define do
  factory :project, class: 'Ganttin::Project' do
    title { Faker::Lorem.sentence }
    member_ids do
      Array.new(rand(10)) do
        create(:user).id
      end
    end
  end
end
