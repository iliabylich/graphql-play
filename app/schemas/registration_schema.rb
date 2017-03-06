RegistrationSchema = Dry::Validation.Schema do
  required(:email) { str? & format?(/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i) }
  required(:password) { str? & min_size?(5) }
  required(:name) { str? & filled? }
end
