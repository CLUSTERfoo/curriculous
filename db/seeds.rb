User.new(
  username: 'clusterfoo',
  password: '12345',
  password_confirmation: '12345'
).save

User.new(
  username: 'another_username',
  email:    'another_username@email.com',
  password: '12345',
  password_confirmation: '12345'
).save

User.new(
  username: 'Noam',
  password: '12345',
  password_confirmation: '12345'
).save
