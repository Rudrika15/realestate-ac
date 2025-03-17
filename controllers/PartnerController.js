const { User, ProjectPartner, Project } = require('../models')
const { Partner, Partner2 } = require('../models/Partner')
const sequelize = require('../config/database')

exports.getPartners = async (req, res) => {
  try {
    const partners = await Partner.findAll({
      include: [
        {
          model: Project,
          as: 'projects',
          attributes: ['projectName'],
          through: {
            attributes: ['percentage'] // Include the 'percentage' attribute from the join table
          }
        },
        {
          model: User,
          as: 'PartnercreatedBy',
          attributes: ['userName']
        },
        {
          model: User,
          as: 'PartnerupdatedBy',
          attributes: ['userName']
        }
      ]
    })

    res.status(200).json({
      status: true,
      message: 'Partners fetched successfully',
      data: partners
    })
  } catch (error) {
    res.status(500).json({
      status: false,
      error: error.message,
      message: 'An error occurred while fetching the partners'
    })
  }
}
exports.getSinglePartner = async (req, res) => {
  try {
    const { id } = req.params
    const partner = await Partner.findOne({ where: { id } })
    if (!partner) {
      return res.status(404).json({ message: 'Partner not found' })
    }
    res.status(200).json({
      status: true,
      message: 'Partner fetched successfully',
      data: partner
    })
  } catch (error) {
    res.status(500).json({
      status: false,
      error: error.message,
      message: 'An error occurred while fetching the partner'
    })
  }
}

exports.getPartnerById = async (req, res) => {
  try {
    const { id } = req.params
    // const partner = await ProjectPartner.findOne({
    //   where: { id },
    // });
    const partner = await ProjectPartner.findAll({
      where: { partnerId: id },
      include: [
        {
          model: Project,
          as: 'project',
          attributes: ['projectName']
        },
        // {
        //   model: Partner,
        //   as: "ProjectPartners",
        //   attributes: ["partnerName"],
        // },
        {
          model: User,
          as: 'ProjectPartnercreatedBy',
          attributes: ['userName']
        },
        {
          model: User,
          as: 'ProjectPartnerupdatedBy',
          attributes: ['userName']
        }
      ]
    })
    if (!partner) {
      return res.status(404).json({ message: 'Partner not found' })
    }
    res.status(200).json({
      status: true,
      message: 'Partner fetched successfully',
      data: partner
    })
  } catch (error) {
    res.status(500).json({
      status: false,
      error: error.message,
      message: 'An error occurred while fetching the partner'
    })
  }
}

exports.createPartner = async (req, res) => {
  const { partner_name, projectPartners } = req.body // Expecting `projectPartners` to be an array
  const userId = req.userId

  // Input Validation
  if (!partner_name) {
    return res.status(400).json({
      status: false,
      message: 'partner_name is required'
    })
  }

  if (
    !projectPartners ||
    !Array.isArray(projectPartners) ||
    projectPartners.length === 0
  ) {
    return res.status(400).json({
      status: false,
      message: 'projectPartners must be a non-empty array'
    })
  }

  const transaction = await sequelize.transaction()

  try {
    // Create Partner
    const partner = await Partner.create(
      {
        partnerName: partner_name,
        createdBy: userId,
        updatedBy: userId,
        createdAt: new Date(),
        updatedAt: new Date()
      },
      { transaction }
    )

    // Prepare ProjectPartner records
    const projectPartnerRecords = projectPartners.map(
      ({ projectId, percentage }) => ({
        projectId,
        partnerId: partner.id,
        percentage,
        createdBy: userId,
        updatedBy: userId,
        createdAt: new Date(),
        updatedAt: new Date()
      })
    )

    // Bulk Create ProjectPartners
    const createdProjectPartners = await ProjectPartner.bulkCreate(
      projectPartnerRecords,
      {
        transaction
      }
    )

    // Commit Transaction
    await transaction.commit()

    // Success Response
    return res.status(200).json({
      status: true,
      message: 'Partner and associated project partners created successfully',
      data: { partner, projectPartners: createdProjectPartners }
    })
  } catch (error) {
    // Rollback Transaction on Error
    await transaction.rollback()
    return res.status(500).json({
      status: false,
      message: 'An error occurred while creating the partner',
      error: error.message
    })
  }
}

exports.updatePartner = async (req, res) => {
  const { percentages, projectIds } = req.body
  const { partnerId } = req.params
  const userId = req.userId

  if (
    !partnerId ||
    !percentages ||
    !projectIds ||
    percentages.length !== projectIds.length
  ) {
    return res.status(400).json({
      status: false,
      message: 'Invalid input data'
    })
  }

  const transaction = await sequelize.transaction()

  try {
    for (let i = 0; i < projectIds.length; i++) {
      const projectId = projectIds[i]
      const percentage = percentages[i]

      // Check if the record exists
      const existingRecord = await ProjectPartner.findOne({
        where: { partnerId, projectId },
        transaction
      })

      if (existingRecord) {
        // Update the existing record
        await ProjectPartner.update(
          { percentage, updatedBy: userId },
          { where: { id: existingRecord.id }, transaction }
        )
      } else {
        // Add a new record
        await ProjectPartner.create(
          {
            partnerId,
            projectId,
            percentage,
            createdBy: userId,
            updatedBy: userId
          },
          { transaction }
        )
      }
    }

    await transaction.commit()

    res.status(200).json({
      status: true,
      message: 'Partner associations updated successfully'
    })
  } catch (error) {
    await transaction.rollback()
    res.status(500).json({
      status: false,
      error: error.message,
      message: 'An error occurred while updating the partner associations'
    })
  }
}

exports.deletePartner = async (req, res) => {
  try {
    const { id } = req.params
    const userId = req.userId // Assuming this is retrieved via middleware

    // Validate input
    if (!id) {
      return res.status(400).json({
        status: false,
        message: 'Partner ID is required'
      })
    }
    const projectPartner = await ProjectPartner.findOne({
      where: {
        id: id
      }
    })
    await projectPartner.destroy()

    res.status(200).json({
      status: true,
      message: 'Partner deleted successfully'
    })
  } catch (error) {
    return res.status(500).json({
      status: false,
      error: error.message,
      message: 'An error occurred while deleting the partner'
    })
  }
}

exports.partnerDelete = async (req, res) => {
  try {
    const { id } = req.params
    const partner = await Partner.findOne({ where: { id } })

    if (!partner) {
      return res.status(404).json({ message: 'Partner not found' })
    }
    const projectPartner = await ProjectPartner.findAll({
      where: { partnerId: id }
    })
    if (projectPartner.length > 0) {
      return res.status(404).json({
        message: 'Partner is associated with projects and cannot be deleted'
      })
    }
    await partner.destroy()
    res.status(200).json({
      status: true,
      message: 'Partner deleted successfully'
    })
  } catch (error) {
    res.status(500).json({
      status: false,
      error: error.message,
      message: 'An error occurred while deleting the partner'
    })
  }
}
exports.getPartnerProjects = async (req, res) => {
  try {
    const { partnerId } = req.params
    const projects = await ProjectPartner.findAll({
      where: {
        partnerId: partnerId
      },
      include: [
        {
          model: Project,
          as: 'project'
        }
      ]
    })
    res.status(200).json({
      status: true,
      message: 'Projects retrieved successfully',
      data: {
        projects
      }
    })
  } catch (error) {
    res.status(500).json({
      status: false,
      error: error.message,
      message: 'An error occurred while retrieving projects'
    })
  }
}
