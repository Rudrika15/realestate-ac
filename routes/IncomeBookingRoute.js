const express = require('express')
const { getIncomeBooking,addIncomeBooking
 } = require('../controllers/IncomeBookingController')

const router = express.Router()

router.get('/get-income-booking', getIncomeBooking)
router.post('/add-income-booking', addIncomeBooking)

module.exports = router
