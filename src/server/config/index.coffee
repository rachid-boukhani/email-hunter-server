config =
  env: process.env.NODE_ENV or 'development'
  port: process.env.PORT or 3000
  db: url: 'mongodb://localhost/nodeblog'

export default config
