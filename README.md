```
git clone https://github.com/iliabylich/graphql-play.git

cd graphql-play
bundle

rake db:create db:migrate
rails s

open http://localhost:3000/api/docs

RAILS_ENV=test rale db:create db:migrate
rspec
```
