const path = require("path");
const {
  Project,
  User,
  ProjectUnit,
  ProjectStage,
  ProjectPartner,
} = require("../models");
const XLSX = require("xlsx");
const multer = require("multer");
const sequelize = require("../config/database");

exports.downloadExcel = async (req, res) => {
  try {
    const filePath = path.join(__dirname, "../storage/demoUnit.xlsx");

    return res.download(filePath, "demoUnit.xlsx", (err) => {
      if (err) {
        return res.status(500).json({
          status: false,
          message: "Failed to download the file",
          error: err.message,
        });
      }
    });
  } catch (err) {
    return res.status(500).json({
      status: false,
      message: "An error occurred while processing your request",
      error: err.message,
    });
  }
};
const upload = multer({ dest: "uploads/" });

exports.storeProject = async (req, res) => {
  const { project_name } = req.body;
  const userId = req.userId;
  const file = req.file;

  // Validate input
  if (!project_name) {
    return res.status(400).json({
      status: false,
      message: "Project name is required",
    });
  }

  if (!file) {
    return res.status(400).json({
      status: false,
      message: "Excel file is required",
    });
  }

  //check project name is
  const existingProject = await Project.findOne({
    where: { projectName: project_name },
  });
  if (existingProject) {
    return res.status(200).json({
      status: false,
      message: "Project name already exists",
    });
  }

  // Start a transaction
  const transaction = await sequelize.transaction();

  try {
    const project = await Project.create(
      {
        projectName: project_name,
        createdBy: userId,
        updatedBy: userId,
      },
      { transaction }
    );
    const projectId = project.id;

    const workbook = XLSX.readFile(file.path);
    const sheetName = workbook.SheetNames[0];
    const sheetData = XLSX.utils.sheet_to_json(workbook.Sheets[sheetName]);

    if (sheetData.length === 0) {
      throw new Error("Excel file is empty");
    }

    const units = sheetData.map((row) => ({
      projectId: projectId,
      unitType: row["Unit type"] || null,
      unitNo: row["Unit no"] || null,
      wing: row["Wing"] || null,
      size: row["Size"] || null,
      currerntStatus: row["Currernt status"] || null,
      saleDeedAmount: row["Sale deed amount"] || null,
      extraWorkAmount: row["Extra work amount"] || null,
      terraceStatus: row["Terrace status"] || null,
      terraceSize: row["Terrace size"] || null,
      createdBy: userId,
      updatedBy: userId,
    }));

    await ProjectUnit.bulkCreate(units, { transaction });

    await transaction.commit();

    return res.status(200).json({
      status: true,
      message: "Project and units added successfully",
      data: { project, units },
    });
  } catch (error) {
    await transaction.rollback();

    return res.status(500).json({
      status: false,
      message: "An error occurred while processing your request",
      error: error.message,
    });
  }
};
exports.getProject = async (req, res) => {
  try {
    const project = await Project.findAll({
      include: [
        {
          model: User,
          as: "ProjectcreatedBy",
          attributes: ["userName"],
        },
        {
          model: User,
          as: "ProjectupdatedBy",
          attributes: ["userName"],
        },
      ],
    });

    return res.status(200).json({
      status: true,
      message: "Project fetched successfully",
      data: project,
    });
  } catch (error) {
    return res.status(500).json({
      status: false,
      message: "An error occurred while processing your request",
      error: error.message,
    });
  }
};

// exports.getProject = async (req, res) => {
//   try {
//     const projectQuery = `SELECT p.*,ps.* FROM projects p ,projectstages ps where p.id =ps.projectId`; // Correct SQL query

//     const projects = await sequelize.query(projectQuery, {
//       type: Sequelize.QueryTypes.SELECT, // Ensure results are returned as plain JSON
//     });

//     return res.status(200).json({
//       status: true,
//       message: "Projects retrieved successfully.",
//       data: projects, // Return actual data
//     });
//   } catch (err) {
//     return res.status(500).json({
//       status: false,
//       message: "An error occurred while retrieving projects.",
//       error: err.message,
//     });
//   }
// };
exports.projectUnit = async (req, res) => {
  try {
    const projectId = req.params.id;
    const projectUnit = await ProjectUnit.findAll(
      {
        where: {
          projectId: projectId,
          currerntStatus: "Unsold",
        },
      },
      {
        include: [
          {
            model: User,
            as: "ProjectUnitcreatedBy",
            attributes: ["userName"],
          },
          {
            model: User,
            as: "ProjectUnitupdatedBy",
            attributes: ["userName"],
          },
        ],
      }
    );

    return res.status(200).json({
      status: true,
      message: "Project Unit fetched successfully",
      data: projectUnit,
    });
  } catch (error) {
    return res.status(500).json({
      status: false,
      message: "An error occurred while processing your request",
      error: error.message,
    });
  }
};

exports.getWing = async (req, res) => {
  try {
    const projectId = req.params.id;
    const projectUnit = await ProjectUnit.findAll({
      where: {
        projectId: projectId,
      },
    });

    // Extract the wings (first part of unitNo before '-')
    const wings = projectUnit.map((unit) => unit.unitNo.split("-")[0]);

    // Remove duplicate wings using a Set
    const uniqueWings = [...new Set(wings)];

    return res.status(200).json({
      status: true,
      message: "Project Unit fetched successfully",
      data: uniqueWings,
    });
  } catch (error) {
    return res.status(500).json({
      status: false,
      message: "An error occurred while processing your request",
      error: error.message,
    });
  }
};

exports.deleteProject = async (req, res) => {
  try {
    const { id } = req.params;
    const project = await Project.findOne({ where: { id } });
    if (!project) {
      return res.status(200).json({
        status: false,
        message: "Project not found",
      });
    }

    const projectStage = await ProjectStage.findOne({
      where: { projectId: id },
    });
    if (projectStage) {
      await ProjectStage.destroy({ where: { projectId: id } });
    }
    const projectUnit = await ProjectUnit.findOne({
      where: { projectId: id },
    });
    if (projectUnit) {
      await ProjectUnit.destroy({ where: { projectId: id } });
    }
    const projectPartner = await ProjectPartner.findOne({
      where: { projectId: id },
    });
    if (projectPartner) {
      await ProjectPartner.destroy({ where: { projectId: id } });
    }
    await project.destroy();
    return res.json({
      status: true,
      message: "Project deleted successfully",
    });
  } catch (err) {
    return res.status(500).json({ status: false, error: err.message });
  }
};
