const express = require("express");
const {
  storeProjectStage,
  getProjectStage,
  getProjectStageById,
  updateProjectStage,
  deleteProjectStage,
} = require("../controllers/ProjectStageController");
const router = express.Router();

//

router.post("/store-project-stage", storeProjectStage);
router.get("/get-project-stage/:projectId", getProjectStage);
router.get("/get-project-stage-by-id/:id", getProjectStageById);
router.post("/update-project-stage/:id", updateProjectStage);
router.delete("/delete-project-stage/:id", deleteProjectStage);

module.exports = router;
