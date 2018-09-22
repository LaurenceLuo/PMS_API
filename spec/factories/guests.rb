FactoryBot.define do
    factory :guest do
        name { Faker::StarWars.character }
        done false
        room_id nil
    end
end
