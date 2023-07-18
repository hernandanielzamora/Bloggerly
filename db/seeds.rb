# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create new users
first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.')


# Create posts for first user
4.times do
  post = Post.create(author: first_user, title: 'Hello', text: 'This is my first post')

  puts "Post #{post.id} created"

  #Create comments for first user post
  Comment.create(post: post, author: second_user, text: 'Hi Tom!')
  Comment.create(post: post, author: second_user, text: 'Really like your post!!')
  Comment.create(post: post, author: second_user, text: 'You are the best!')
  Comment.create(post: post, author: second_user, text: 'Keep up the good work!')
  Comment.create(post: post, author: second_user, text: 'Keep pushing it!')
  Comment.create(post: post, author: second_user, text: 'Well deserved!')

  puts "#{post.comments.count} | Comments for post #{post.title} created"

end

# Using CRUD methods (to find, update and delete)

# Find and Update
find_user = User.find_by(name: 'Lilly')
puts "User #{find_user.name} found"
find_user.update(name: 'Lilly Potter')
puts "User #{find_user.name} updated"

# Creating a post for global use
post = Post.create(author: first_user, title: 'Hello', text: 'This is my first post')
Comment.create(post: post, author: second_user, text: 'Hi Tom!')

# Find and Delete
find_comment = post.comments.find_by(text: 'Hi Tom!') if post
puts "Comment Text: #{find_comment.text}"
find_comment.destroy
puts "Comment Count after deletion: #{post.comments.count}"

# Custom Methods application

# User Model: Returns 3 most recent posts for a user
last_posts = first_user.last_posts
puts "Last posts for user #{first_user.name}: "
last_posts.each do |item|
  puts "Post #{item.id} | #{item.title} | #{item.text}"
end

# Post Model: Method that updates the posts counter for a user
puts "Posts counter for user #{first_user.name}: #{first_user.posts_counter}"

# Post Model: Method which returns the 5 most recent comments for a given post
post_with_comments = Post.find_by(title: 'Hello')
post_author = post_with_comments.author.name
last_comments = post_with_comments.last_comments
puts "Last comments in '#{post_with_comments.title}' by '#{post_author}' for user: '#{find_user.name}': "
last_comments.each do |item|
  puts "Comment #{item.id} | #{item.text}"
end

# Comment Model: Method that updates the comments counter for a post
puts "There are #{post_with_comments.comments_counter} comments for post '#{post_with_comments.title}'"

# Like Model: Method that updates the likes counter for a post
puts "There are #{post_with_comments.likes_counter} likes for post '#{post_with_comments.title}'"
