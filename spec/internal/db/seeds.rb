User.create(name: "Bryan Ricker", username: "bricker", email: "bricker@kpcc.org", password: "secret", is_superuser: true, can_login: true)

Outpost.config.registered_models.each do |model|
  Outpost::Permission.create(resource: model)
end

10.times do |n|
  Person.create(
    :name       => "Test Person #{n}",
    :email      => "test#{n}@gmail.com",
    :location   => "Los Angeles",
    :age        => "#{n + 20}"
  )
end
