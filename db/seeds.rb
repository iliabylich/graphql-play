Post.delete_all
User.delete_all

user1 = User.create(email: 'email1@email.com', password: 'password1', name: 'User 1')
user2 = User.create(email: 'email2@email.com', password: 'password2', name: 'User 2')

post1 = Post.create(title: 'title 1', body: 'body 1', user: user1)
post2 = Post.create(title: 'title 2', body: 'body 2', user: user2)
post3 = Post.create(title: 'title 3', body: 'body 3', user: user2)

user1.followers << user2
