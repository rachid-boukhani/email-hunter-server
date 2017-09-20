import express  from 'express'
import mongoose  from 'mongoose'
import config  from './config'
import appMiddlware from './middleware/appMiddlware'

import auth from './auth/router'

app = express()
mongoose.connect config.db.url

# setup the app middlware
appMiddlware app

app.use '/auth', auth

app.use (req, res) ->
  res.send ok: 1
  return

export default app
