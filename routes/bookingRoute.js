const express = require("express");
const router = express.Router();

const {
  storeBooking,
  getProjectWiseStages,
  getBookings,
  getBookingAndPaymentHistory,
} = require("../controllers/BookingController");

router.post("/store-booking", storeBooking);
router.get("/get-bookings", getBookings);
router.get(
  "/project-wise-stages/:projectId/:projectWingId",
  getProjectWiseStages
);

router.get("/get-booking-and-payment-history", getBookingAndPaymentHistory);
module.exports = router;
