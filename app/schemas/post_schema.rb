PostSchema = Dry::Validation.Schema do
  required(:title) { str? & filled? & max_size?(40) }
  required(:body) { str? & filled? & max_size?(200) }
end
