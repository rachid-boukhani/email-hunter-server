mongoose = require('mongoose')
bcrypt = require('bcrypt-nodejs')

schema = mongoose.Schema(
  name:
    type: String
    required: true
    unique: true
  owner:
    type: mongoose.Schema.Types.ObjectId
    ref: 'user'
  domains: [ { type: String } ])
module.exports = mongoose.model('search', schema)
