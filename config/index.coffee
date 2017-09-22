module.exports =
  env: process.env.NODE_ENV or 'development'
  port: process.env.PORT or 3000
  seed: process.env.NODE_ENV == 'development'
  db: url: process.env.MONGODB_URI or 'mongodb://localhost/emailhunter'
  API: path: 'https://api.hunter.io/v2/email-count?domain=[:domain]'
