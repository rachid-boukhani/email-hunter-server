Router = require('express').Router
isLoggedIn = require('../utils/loggedIn')
loginController = require('../controllers/login')

router = Router()

router.route('/').get isLoggedIn, loginController.getHome
router.route('/home').get isLoggedIn, loginController.getHome
router.route('/login').get(loginController.getLogin).post loginController.postLogin
router.route('/signup').get(loginController.getSignup).post loginController.postSignup
router.route('/logout').get loginController.logout

module.exports = router
