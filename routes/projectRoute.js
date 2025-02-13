const express = require("express");
const router = express.Router();

const {
  downloadExcel,
  storeProject,
  getProject,
  projectUnit,
  getWing,
  getProjectWiseWing,
  deleteProject,
} = require("../controllers/ProjectController");
const multer = require("multer");
const upload = multer({ dest: "uploads/" });

router.get("/download-excel", downloadExcel);
router.post("/store-project", upload.single("file"), storeProject);
router.get("/get-project", getProject);
router.get("/get-project-unit/:id", projectUnit);
router.get("/get-project-wing/:id", getWing);
router.delete("/delete-project/:id", deleteProject);

module.exports = router;
