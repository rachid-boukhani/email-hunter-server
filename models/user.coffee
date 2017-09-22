mongoose = require('mongoose')
bcrypt = require('bcrypt-nodejs')
# define the schema for our user model
schema = mongoose.Schema(
  email: String
  password: String)

# We need to hash the password before saving the user
schema.pre 'save', (next) ->
  if @isModified('password')
    @password = @generateHash(@password)
    next()
  else
    next()

schema.methods.generateHash = (password) ->
  bcrypt.hashSync password, bcrypt.genSaltSync(8), null

schema.methods.validPassword = (password) ->
  bcrypt.compareSync password, @password

module.exports = mongoose.model('user', schema)
