const express = require("express");
const router = express.Router();

const { storeBooking } = require("../controllers/BookingController");

router.post("/store-booking", storeBooking);
module.exports = router;
