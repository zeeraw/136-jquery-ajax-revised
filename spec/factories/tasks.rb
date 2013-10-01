FactoryGirl.define do

  factory :task do

    sequence(:name) { |n| "Task no. #{n}" }
    complete false

    factory :completed_task do
      complete true
    end

  end

end
