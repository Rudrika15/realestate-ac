const { User, ProjectPartner, Project } = require("../models");
const Partner = require("../models/Partner");
const sequelize = require("../config/database");

exports.getPartners = async (req, res) => {
  try {
    const partners = await ProjectPartner.findAll({
      include: [
        {
          model: User,
          as: "ProjectPartnercreatedBy",
          attributes: ["userName"],
        },
        {
          model: User,
          as: "ProjectPartnerupdatedBy",
          attributes: ["userName"],
        },
        {
          model: Project,
          as: "project",
          attributes: ["projectName"],
        },
        {
          model: Partner,
          as: "ProjectPartners",
          attributes: ["partnerName"],
        },
      ],
    });

    res.status(200).json({
      status: true,
      message: "Partners fetched successfully",
      data: partners,
    });
  } catch (error) {
    res.status(500).json({
      status: false,
      error: error.message,
      message: "An error occurred while fetching the partners",
    });
  }
};

exports.getPartnerById = async (req, res) => {
  try {
    const { id } = req.params;
    const partner = await Partner.findOne({
      where: { id },
      include: [
        {
          model: User,
          as: "PartnercreatedBy",
          attributes: ["userName"],
        },
        {
          model: User,
          as: "PartnerupdatedBy",
          attributes: ["userName"],
        },
      ],
    });
    if (!partner) {
      return res.status(404).json({ message: "Partner not found" });
    }
    res.status(200).json({
      status: true,
      message: "Partner fetched successfully",
      data: partner,
    });
  } catch (error) {
    res.status(500).json({
      status: false,
      error: error.message,
      message: "An error occurred while fetching the partner",
    });
  }
};
exports.createPartner = async (req, res) => {
  try {
    const { partner_name, percentage, projectId } = req.body;
    const userId = req.userId;

    if (!partner_name) {
      return res.status(400).json({
        status: false,
        message: "partner_name is required",
      });
    }

    if (!percentage) {
      return res.status(400).json({
        status: false,
        message: "percentage is required",
      });
    }

    if (!projectId) {
      return res.status(400).json({
        status: false,
        message: "projectId is required",
      });
    }

    const transaction = await sequelize.transaction();

    try {
      const partner = await Partner.create(
        {
          partnerName: partner_name,
          createdBy: userId,
          updatedBy: userId,
        },
        { transaction }
      );

      const projectPartner = await ProjectPartner.create(
        {
          projectId: projectId,
          partnerId: partner.id,
          percentage: percentage,
          createdBy: userId,
          updatedBy: userId,
        },
        { transaction }
      );

      await transaction.commit();

      res.status(200).json({
        status: true,
        message: "Partner created successfully",
        data: {
          partner,
          projectPartner,
        },
      });
    } catch (error) {
      await transaction.rollback();
      throw error;
    }
  } catch (error) {
    res.status(500).json({
      status: false,
      error: error.message,
      message: "An error occurred while creating the partner",
    });
  }
};

exports.updatePartner = async (req, res) => {
  try {
    const { partner_id, partner_name, percentage, projectId } = req.body;
    const userId = req.userId;

    if (!partner_id) {
      return res.status(400).json({
        status: false,
        message: "partner_id is required",
      });
    }

    if (!partner_name) {
      return res.status(400).json({
        status: false,
        message: "partner_name is required",
      });
    }

    if (!percentage) {
      return res.status(400).json({
        status: false,
        message: "percentage is required",
      });
    }

    if (!projectId) {
      return res.status(400).json({
        status: false,
        message: "projectId is required",
      });
    }

    const transaction = await sequelize.transaction();

    try {
      const partner = await Partner.findByPk(partner_id, { transaction });
      if (!partner) {
        return res.status(404).json({
          status: false,
          message: "Partner not found",
        });
      }

      await partner.update(
        {
          partnerName: partner_name,
          updatedBy: userId,
        },
        { transaction }
      );

      const projectPartner = await ProjectPartner.findOne({
        where: {
          partnerId: partner_id,
          projectId: projectId,
        },
        transaction,
      });

      if (!projectPartner) {
        return res.status(404).json({
          status: false,
          message: "Project-Partner association not found",
        });
      }

      await projectPartner.update(
        {
          percentage: percentage,
          updatedBy: userId,
        },
        { transaction }
      );

      await transaction.commit();

      res.status(200).json({
        status: true,
        message: "Partner updated successfully",
        data: {
          partner,
          projectPartner,
        },
      });
    } catch (error) {
      await transaction.rollback();
      throw error;
    }
  } catch (error) {
    res.status(500).json({
      status: false,
      error: error.message,
      message: "An error occurred while updating the partner",
    });
  }
};

exports.deletePartner = async (req, res) => {
  try {
    const { partner_id, projectId } = req.body;
    const userId = req.userId;

    if (!partner_id) {
      return res.status(400).json({
        status: false,
        message: "partner_id is required",
      });
    }

    if (!projectId) {
      return res.status(400).json({
        status: false,
        message: "projectId is required",
      });
    }

    const transaction = await sequelize.transaction();

    try {
      const projectPartner = await ProjectPartner.findOne({
        where: {
          partnerId: partner_id,
          projectId: projectId,
        },
        transaction,
      });

      if (!projectPartner) {
        return res.status(404).json({
          status: false,
          message: "Project-Partner association not found",
        });
      }

      await projectPartner.destroy({ transaction });

      const partner = await Partner.findByPk(partner_id, { transaction });
      if (!partner) {
        return res.status(404).json({
          status: false,
          message: "Partner not found",
        });
      }

      await partner.destroy({ transaction });

      await transaction.commit();

      res.status(200).json({
        status: true,
        message: "Partner and associated project-partner deleted successfully",
      });
    } catch (error) {
      await transaction.rollback();
      throw error;
    }
  } catch (error) {
    res.status(500).json({
      status: false,
      error: error.message,
      message: "An error occurred while deleting the partner",
    });
  }
};
