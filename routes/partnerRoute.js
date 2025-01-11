const express = require("express");
const router = express.Router();

const {
  getPartners,
  getPartnerById,
  updatePartner,
  deletePartner,
  createPartner,
} = require("../controllers/PartnerController");

router.get("/get-partner", getPartners);
router.post("/add-partner", createPartner);
router.get("/get-partner-by-id/:id", getPartnerById);
router.post("/update-partner/:id", updatePartner);
router.delete("/delete-partner/:id", deletePartner);

module.exports = router;
