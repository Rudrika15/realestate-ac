const express = require("express");
const {
  ProjectStage,
  Project,
  User,
  ProjectStageTransaction,
} = require("../models");

exports.storeProjectStage = async (req, res) => {
  try {
    const {
      projectStageName,
      projectStagePer,
      projectId,
      projectWingData, // Expecting an array of objects
    } = req.body;

    const userId = req.userId;

    // Validation
    if (!projectStageName) {
      return res.status(400).json({
        status: false,
        message: "projectStageName is required",
      });
    }
    if (!projectStagePer) {
      return res.status(400).json({
        status: false,
        message: "projectStagePer is required",
      });
    }
    if (!Array.isArray(projectWingData) || projectWingData.length === 0) {
      return res.status(400).json({
        status: false,
        message: "projectWingData must be a non-empty array",
      });
    }

    // Create ProjectStage
    const projectStage = await ProjectStage.create({
      projectId,
      projectStageName,
      projectStagePer,
      createdBy: userId,
      updatedBy: userId,
    });

    const projectStageId = projectStage.id;

    // Prepare data for ProjectStageTransaction
    const projectStageTransactions = projectWingData.map((wing) => ({
      projectStageId,
      projectWingId: wing.projectWingId,
      status: wing.status,
      projectompletionDate: wing.projectCompletionDate,
      createdBy: userId,
      updatedBy: userId,
    }));

    // Bulk create ProjectStageTransaction
    await ProjectStageTransaction.bulkCreate(projectStageTransactions);

    return res.status(200).json({
      status: true,
      message: "Project Stage created successfully",
      data: projectStage,
    });
  } catch (err) {
    return res.status(500).json({
      status: false,
      message: "An error occurred while processing your request",
      error: err.message,
    });
  }
};

// exports.getProjectStage = async (req, res) => {
//   try {
//     const projectStage = await ProjectStage.findAll({
//       include: [
//         {
//           model: Project,

//           as: "Project",
//           attributes: ["projectName"],
//         },
//         {
//           model: User,
//           as: "ProjectStagecreatedBy",
//           attributes: ["userName"],
//         },
//         {
//           model: User,
//           as: "ProjectStageupdatedBy",
//           attributes: ["userName"],
//         },
//       ],
//     });
//     return res.status(200).json({
//       status: true,
//       message: "Project Stage fetched successfully",
//       data: projectStage,
//     });
//   } catch (err) {
//     return res.status(500).json({
//       status: false,
//       message: "An error occurred while processing your request",
//       error: err.message,
//     });
//   }
// };
exports.getProjectStage = async (req, res) => {
  try {
    const { projectId } = req.params;

    console.log(projectId);

    if (!projectId) {
      return res.status(400).json({
        status: false,
        message: "projectId is required",
      });
    }

    const projectExists = await Project.findOne({ where: { id: projectId } });
    if (!projectExists) {
      return res.status(400).json({
        status: false,
        message: "Invalid projectId. No project found with the provided ID.",
      });
    }

    const projectStages = await ProjectStage.findAll({
      where: { projectId },
      include: [
        {
          model: ProjectStageTransaction,
          as: "transactions",
          attributes: [
            "id",
            "projectWingId",
            "status",
            "projectCompletionDate",
            "actualCompletionDate",
          ],
        },
      ],
      attributes: [
        "id",
        "projectStageName",
        "projectStagePer",
        "createdBy",
        "updatedBy",
        "createdAt",
        "updatedAt",
      ],
    });

    if (!projectStages || projectStages.length === 0) {
      return res.status(404).json({
        status: false,
        message: "No project stages found for the provided projectId.",
      });
    }

    return res.status(200).json({
      status: true,
      message: "Project stages retrieved successfully.",
      data: projectStages,
    });
  } catch (err) {
    return res.status(500).json({
      status: false,
      message: "An error occurred while processing your request.",
      error: err.message,
    });
  }
};

exports.getProjectStageById = async (req, res) => {
  try {
    const { id } = req.params;
    const projectStage = await ProjectStage.findOne({
      where: { id },
      include: [
        {
          model: Project,
          as: "Project",
          attributes: ["projectName"],
        },
        {
          model: User,
          as: "ProjectStagecreatedBy",
          attributes: ["userName"],
        },
        {
          model: User,
          as: "ProjectStageupdatedBy",
          attributes: ["userName"],
        },
      ],
    });

    return res.status(200).json({
      status: true,
      message: "Project Stage fetched successfully",
      data: projectStage,
    });
  } catch (err) {
    return res.status(500).json({
      status: false,
      message: "An error occurred while processing your request",
      error: err.message,
    });
  }
};

// exports.updateProjectStage = async (req, res) => {
//   try {
//     const { id } = req.params;
//     const { projectStageName, pojectStagePer, projectId } = req.body;
//     const userId = req.userId;
//     if (!projectStageName) {
//       return res.status(200).json({
//         status: false,
//         message: "projectStageName is required",
//       });
//     }

//     if (!pojectStagePer) {
//       return res.status(200).json({
//         status: false,
//         message: "pojectStagePer is required",
//       });
//     }
//     if (!projectId) {
//       return res.status(200).json({
//         status: false,
//         message: "projectId is required",
//       });
//     }
//     const findProject = await Project.findOne({
//       where: { id: projectId },
//     });

//     const findProjectStage = await ProjectStage.findOne({
//       where: { id, projectId: projectId },
//     });

//     if (!findProjectStage) {
//       return res.status(200).json({
//         status: false,
//         message: "Project Stage id does not match with the project",
//       });
//     }

//     if (!findProject) {
//       return res.status(200).json({
//         status: false,
//         message: "Project not found",
//       });
//     }

//     const projectStage = await ProjectStage.findOne({
//       where: { id },
//     });

//     if (!projectStage) {
//       return res.status(200).json({
//         status: false,
//         message: "Project Stage not found",
//       });
//     }

//     projectStage.projectStageName = projectStageName;
//     projectStage.pojectStagePer = pojectStagePer;
//     projectStage.projectId = projectId;
//     projectStage.updatedBy = userId;

//     await projectStage.save();

//     return res.status(200).json({
//       status: true,
//       message: "Project Stage updated successfully",
//       data: projectStage,
//     });
//   } catch (err) {
//     return res.status(500).json({
//       status: false,
//       message: "An error occurred while processing your request",
//       error: err.message,
//     });
//   }
// };
exports.updateProjectStage = async (req, res) => {
  try {
    const { id } = req.params;
    const { projectStageName, projectStagePer, projectId } = req.body;
    const userId = req.userId;
    if (!projectStageName) {
      return res.status(200).json({
        status: false,
        message: "projectStageName is required",
      });
    }

    if (!projectStagePer) {
      return res.status(200).json({
        status: false,
        message: "projectStagePer is required",
      });
    }
    if (!projectId) {
      return res.status(200).json({
        status: false,
        message: "projectId is required",
      });
    }
    const projectStage = await ProjectStage.findOne({
      where: { id },
    });

    if (!projectStage) {
      return res.status(200).json({
        status: false,
        message: "Project Stage not found",
      });
    }

    projectStage.projectStageName = projectStageName;
    projectStage.projectStagePer = projectStagePer;
    projectStage.projectId = projectId;
    projectStage.updatedBy = userId;

    await projectStage.save();

    return res.status(200).json({
      status: true,
      message: "Project Stage updated successfully",
      data: projectStage,
    });
  } catch (err) {
    return res.status(500).json({
      status: false,
      message: "An error occurred while processing your request",
      error: err.message,
    });
  }
};
exports.deleteProjectStage = async (req, res) => {
  try {
    const { id } = req.params;
    const projectStage = await ProjectStage.findOne({ where: { id } });
    if (!projectStage) {
      return res.status(200).json({
        status: false,
        message: "Project Stage not found",
      });
    }
    await projectStage.destroy();
    return res.json({
      status: true,
      message: "Project Stage deleted successfully",
    });
  } catch (err) {
    return res.status(500).json({ status: false, error: err.message });
  }
};
