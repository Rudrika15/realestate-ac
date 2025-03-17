const {
  PartnerIncomeDb1,
  PartnerIncomeDb2,
  Income1,
  Income2,
  Partner,
  Project
} = require('../models')
const { Op } = require('sequelize')

exports.createPartnerIncome = async (req, res) => {
  const {
    projectId,
    amount,
    paymentMode,
    dateReceived,
    PartnerId,
    bankName,
    chequeNumber,
    chequeDate
  } = req.body

  const incomeType = 'Partner'
  const userId = req.userId

  // ✅ **Validation checks**
  if (!PartnerId)
    return res
      .status(200)
      .json({ success: false, message: 'Partner is required' })
  if (!projectId)
    return res
      .status(200)
      .json({ success: false, message: 'Project is required' })
  if (!amount)
    return res
      .status(200)
      .json({ success: false, message: 'Amount is required' })
  if (!paymentMode)
    return res
      .status(200)
      .json({ success: false, message: 'Payment Mode is required' })
  if (!dateReceived)
    return res
      .status(200)
      .json({ success: false, message: 'Date Received is required' })

  try {
    // ✅ **Create Income entry in db1**
    const incomeDb1 = await Income1.create({
      projectId,
      incomeType,
      amount,
      paymentMode,
      dateReceived,
      createdBy: userId,
      updatedBy: userId
    })

    // ✅ **Create Partner Income entry in db1**
    const partnerIncomeDb1 = await PartnerIncomeDb1.create({
      incomeId: incomeDb1.id,
      partnerId: PartnerId,
      bankName,
      chequeNumber,
      chequeDate,
      createdBy: userId,
      updatedBy: userId
    })

    // ✅ **If paymentMode is 'cash', update DB2 in the background**
    if (paymentMode === 'cash') {
      console.log(
        '✅ Payment mode is CASH, inserting into DB2 in background...'
      )
      ;(async () => {
        try {
          const incomeDb2 = await Income2.create({
            projectId,
            incomeType,
            amount,
            paymentMode,
            dateReceived,
            createdBy: userId,
            updatedBy: userId
          })

          await PartnerIncomeDb2.create({
            incomeId: incomeDb2.id,
            partnerId: PartnerId,
            bankName,
            chequeNumber,
            chequeDate,
            createdBy: userId,
            updatedBy: userId
          })

          console.log('✅ DB2 insert completed.')
        } catch (error) {
          console.error('❌ Error inserting into DB2:', error)
        }
      })()
    }

    return res.status(200).json({
      success: true,
      message: 'Income created successfully',
      data: incomeDb1 // ✅ Keeps the original response
    })
  } catch (error) {
    console.error('❌ Error creating Partner Income:', error)
    return res.status(500).json({ success: false, message: error.message })
  }
}

// Get All Partner Incomes
exports.getAllPartnerIncomes = async (req, res) => {
  try {
    const { partnerId, projectId, startDate, endDate } = req.query

    // Build the where clause dynamically
    let whereCondition = {
      incomeType: 'Partner'
    }

    if (projectId) {
      whereCondition.projectId = projectId
    }

    if (startDate && endDate) {
      whereCondition.dateReceived = {
        [Op.between]: [new Date(startDate), new Date(endDate)]
      }
    }

    const incomes = await Income.findAll({
      where: whereCondition,
      include: [
        {
          model: Project,
          attributes: ['id', 'projectName']
        },
        {
          model: PartnerIncome,
          where: partnerId ? { partnerId } : undefined, // Filter partner-wise if provided
          include: [
            {
              model: Partner,
              attributes: ['id', 'partnerName']
            }
          ],
          attributes: ['incomeId', 'partnerId', 'chequeNumber', 'chequeDate']
        }
      ]
    })

    return res.status(200).json({
      success: true,
      data: incomes
    })
  } catch (error) {
    console.error('Error details:', error)
    return res.status(500).json({
      success: false,
      message: 'Failed to retrieve incomes',
      error: error.message
    })
  }
}
exports.deletePartnerIncome = async (req, res) => {
  const id = req.params.id

  try {
    const partnerIncome = await PartnerIncome.findOne({
      where: { id: id }
    })

    if (!partnerIncome) {
      return res.status(404).json({ message: 'Income not found' })
    }
    const incomeId = partnerIncome.incomeId
    await Income.destroy({ where: { id: incomeId } })

    await partnerIncome.destroy()
    res.status(200).json({ message: 'Income deleted successfully' })
  } catch (error) {
    res.status(500).json({ message: error.message })
  }
}
exports.getPartnerIncomeDetail = async (req, res) => {
  const id = req.params.id

  try {
    const partnerIncome = await PartnerIncome.findOne({
      where: { id: id },
      include: [
        {
          model: Income,
          include: [
            {
              model: Project,
              attributes: ['id', 'projectName']
            }
          ]
        },
        {
          model: Partner,
          attributes: ['id', 'partnerName']
        }
      ]
    })

    if (!partnerIncome) {
      return res.status(404).json({ message: 'Income not found' })
    }

    res.status(200).json({ data: partnerIncome })
  } catch (error) {
    res.status(500).json({ message: error.message })
  }
}

exports.updatePartnerIncome = async (req, res) => {
  const id = req.params.id
  const {
    projectId,
    amount,
    paymentMode,
    dateReceived,
    partnerId,
    bankName,
    chequeNumber,
    chequeDate
  } = req.body
  const userId = req.userId

  try {
    // ✅ **Find the Partner Income record in DB1**
    const partnerIncome = await PartnerIncomeDb1.findByPk(id, {
      include: [{ model: Income1 }]
    })

    if (!partnerIncome) {
      return res
        .status(200)
        .json({ success: false, message: 'Income not found' })
    }

    // ✅ **Validation Checks**
    const findProject = await Project.findOne({ where: { id: projectId } })
    if (!findProject)
      return res
        .status(200)
        .json({ success: false, message: 'Project not found' })

    const findPartner = await Partner.findOne({ where: { id: partnerId } })
    if (!findPartner)
      return res
        .status(200)
        .json({ success: false, message: 'Partner not found' })

    const dateFormatted = new Date(dateReceived)
    if (isNaN(dateFormatted.getTime())) {
      return res
        .status(400)
        .json({ success: false, message: 'Invalid date format' })
    }

    // ✅ **Update PartnerIncome in DB1**
    await partnerIncome.update({
      partnerId: partnerId ?? partnerIncome.partnerId,
      bankName: bankName ?? partnerIncome.bankName,
      chequeNumber: chequeNumber ?? partnerIncome.chequeNumber,
      chequeDate: chequeDate ?? partnerIncome.chequeDate,
      updatedBy: userId
    })

    // ✅ **Update associated Income in DB1**
    if (partnerIncome.Income) {
      await partnerIncome.Income.update({
        projectId: projectId ?? partnerIncome.Income.projectId,
        amount: amount ?? partnerIncome.Income.amount,
        paymentMode: paymentMode ?? partnerIncome.Income.paymentMode,
        dateReceived: dateReceived ?? partnerIncome.Income.dateReceived,
        updatedBy: userId
      })
    }

    // ✅ **If paymentMode is "cash", update DB2 in the background**
    if (paymentMode === 'cash') {
      console.log('✅ Payment mode is CASH, updating DB2 in background...')
      ;(async () => {
        try {
          // Find the PartnerIncome in DB2
          const partnerIncomeDb2 = await PartnerIncomeDb2.findOne({
            where: { incomeId: partnerIncome.incomeId }
          })

          if (partnerIncomeDb2) {
            await partnerIncomeDb2.update({
              partnerId: partnerId ?? partnerIncomeDb2.partnerId,
              bankName: bankName ?? partnerIncomeDb2.bankName,
              chequeNumber: chequeNumber ?? partnerIncomeDb2.chequeNumber,
              chequeDate: chequeDate ?? partnerIncomeDb2.chequeDate,
              updatedBy: userId
            })

            // Find and update Income in DB2
            const incomeDb2 = await Income2.findOne({
              where: { id: partnerIncomeDb2.incomeId }
            })

            if (incomeDb2) {
              await incomeDb2.update({
                projectId: projectId ?? incomeDb2.projectId,
                amount: amount ?? incomeDb2.amount,
                paymentMode: paymentMode ?? incomeDb2.paymentMode,
                dateReceived: dateReceived ?? incomeDb2.dateReceived,
                updatedBy: userId
              })
            }

            console.log('✅ DB2 update completed.')
          } else {
            console.log(
              '⚠️ No matching PartnerIncome found in DB2. Skipping update.'
            )
          }
        } catch (error) {
          console.error('❌ Error updating DB2 in background:', error)
        }
      })()
    }

    // ✅ **Return response (DB2 update happens in background)**
    res.status(200).json({
      success: true,
      message: 'Income updated successfully',
      data: { partnerIncome, income: partnerIncome.Income } // ✅ Keeps original response format
    })
  } catch (error) {
    console.error('❌ Error updating Partner Income:', error)
    return res.status(500).json({ success: false, message: error.message })
  }
}
