const express = require("express");
const router = express.Router();

const {
  getPartners,
  getPartnerById,
  updatePartner,
  deletePartner,
  createPartner,
  getPartnerProjects,
  getSinglePartner,
  partnerDelete,
} = require("../controllers/PartnerController");

router.get("/get-partner", getPartners);
router.post("/add-partner", createPartner);
router.get("/get-partner-by-id/:id", getPartnerById);
router.get("/get-single-partner/:id", getSinglePartner);
router.post("/update-partner/:partnerId", updatePartner);
router.delete("/delete-partner/:id", deletePartner);
router.get("/get-partner-projects/:partnerId", getPartnerProjects);
router.delete("/partner-delete/:id", partnerDelete);

module.exports = router;
