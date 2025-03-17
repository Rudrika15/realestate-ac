const { Income2, Income1 } = require('../models') // ✅ Import Income for both DBs
const {
  InstallmentIncome,
  InstallmentIncome2
} = require('../models/IncomeInstallment')

exports.createInstallment = async (req, res) => {
  const {
    projectId,
    amount,
    paymentMode,
    dateReceived,
    bookingId,
    chequeNumber,
    chequeDate,
    bankName,
    receiptNo,
    receiptDate,
    receiptName,
    loanId,
    verificationStatus,
    verificationDate,
    verificationBy,
    receiptURL
  } = req.body

  const incomeType = 'Installment'
  const userId = req.userId

  // 🔹 **Validation checks**
  if (
    !projectId ||
    !amount ||
    !paymentMode ||
    !dateReceived ||
    !bookingId ||
    !receiptNo ||
    !receiptDate ||
    !bankName
  ) {
    return res
      .status(200)
      .json({ status: false, message: 'All required fields must be provided' })
  }

  try {
    // ✅ **Create Income entry in db1**
    const income = await Income1.create({
      projectId,
      amount,
      paymentMode,
      dateReceived,
      incomeType,
      createdBy: userId,
      updatedBy: userId
    })

    // ✅ **Create Installment Income entry in db1**
    const installment = await InstallmentIncome.create({
      incomeId: income.id,
      bookingId,
      installmentId: income.id,
      chequeNumber,
      chequeDate,
      bankName,
      receiptNo,
      receiptName,
      receiptDate,
      loanId,
      verificationStatus: verificationStatus || 'Pending',
      verificationDate,
      verificationBy,
      receiptURL,
      isDeleted: false,
      isLocked: false,
      createdBy: userId,
      updatedBy: userId
    })

    let installmentDb2 = null // Placeholder for db2 installment

    // ✅ **If paymentMode is 'cash', store data in db2 as well**
    if (paymentMode === 'cash') {
      console.log('✅ Payment mode is CASH, inserting into DB2...')

      // Create Income entry in db2
      const incomeDb2 = await Income2.create({
        projectId,
        amount,
        paymentMode,
        dateReceived,
        incomeType,
        createdBy: userId,
        updatedBy: userId
      })

      // Create Installment Income entry in db2
      installmentDb2 = await InstallmentIncome2.create({
        incomeId: incomeDb2.id,
        bookingId,
        installmentId: incomeDb2.id,
        chequeNumber,
        chequeDate,
        bankName,
        receiptNo,
        receiptName,
        receiptDate,
        loanId,
        verificationStatus: verificationStatus || 'Pending',
        verificationDate,
        verificationBy,
        receiptURL,
        isDeleted: false,
        isLocked: false,
        createdBy: userId,
        updatedBy: userId
      })
    }

    return res.status(200).json({
      status: true,
      message: 'Installment created successfully',
      data: installment
    })
  } catch (error) {
    console.error('❌ Error creating installment:', error)
    return res.status(500).json({ status: false, message: error.message })
  }
}

exports.getInstallments = async (req, res) => {
  try {
    const { installmentId } = req.params // Get installment ID from request params

    let query = {
      include: [
        {
          model: Income1,
          attributes: [
            'id',
            'projectId',
            'amount',
            'paymentMode',
            'dateReceived',
            'incomeType'
          ]
        }
      ]
    }

    if (installmentId) {
      query.where = { id: installmentId }
    }

    const installments = await InstallmentIncome.findAll(query)

    if (!installments || installments.length === 0) {
      return res
        .status(200)
        .json({ status: false, message: 'No installment found' })
    }

    return res.status(200).json({
      status: true,
      message: 'Installment details retrieved successfully',
      data: installments
    })
  } catch (error) {
    console.error(error)
    return res.status(500).json({ status: false, message: error.message })
  }
}
exports.getInstallmentById = async (req, res) => {
  try {
    const installmentId = req.params.id
    const installment = await InstallmentIncome.findOne({
      where: { id: installmentId },
      include: [
        {
          model: Income1,
          attributes: [
            'id',
            'projectId',
            'amount',
            'paymentMode',
            'dateReceived',
            'incomeType'
          ]
        }
      ]
    })

    if (!installment) {
      return res
        .status(200)
        .json({ status: false, message: 'Installment not found' })
    }

    return res.status(200).json({
      status: true,
      message: 'Installment details retrieved successfully',
      data: installment
    })
  } catch (error) {
    console.error(error)
    return res.status(500).json({ status: false, message: error.message })
  }
}
exports.deleteInstallment = async (req, res) => {
  try {
    const installmentId = req.params.id
    const installment = await InstallmentIncome.findOne({
      where: { id: installmentId }
    })

    if (!installment) {
      return res
        .status(200)
        .json({ status: false, message: 'Installment not found' })
    }
    const incomeId = installment.incomeId
    await Income1.destroy({ where: { id: incomeId } })

    await installment.destroy()

    return res.status(200).json({
      status: true,
      message: 'Installment deleted successfully'
    })
  } catch (error) {
    console.error(error)
    return res.status(500).json({ status: false, message: error.message })
  }
}
exports.updateInstallment = async (req, res) => {
  try {
    const installmentId = req.params.id
    const { paymentMode } = req.body

    // 🔹 Check if installment exists in DB1
    const installment = await InstallmentIncome.findOne({
      where: { id: installmentId }
    })

    if (!installment) {
      return res
        .status(200)
        .json({ status: false, message: 'Installment not found' })
    }

    // 🔹 Get the associated incomeId
    const incomeId = installment.incomeId

    // ✅ **Update Installment in DB1**
    await InstallmentIncome.update(req.body, { where: { id: installmentId } })

    // ✅ **Update Income in DB1**
    await Income.update(req.body, { where: { id: incomeId } })

    let updatedInstallmentDb2 = null

    // ✅ **If paymentMode is "cash", update Installment in DB2 as well**
    if (paymentMode === 'cash') {
      console.log('✅ Payment mode is CASH, updating DB2...')

      // 🔹 Check if the installment exists in DB2
      const installmentDb2 = await InstallmentIncome2.findOne({
        where: { installmentId }
      })

      if (installmentDb2) {
        await InstallmentIncome2.update(req.body, { where: { installmentId } })

        // ✅ Update Income in DB2
        await Income2.update(req.body, {
          where: { id: installmentDb2.incomeId }
        })

        updatedInstallmentDb2 = await InstallmentIncome2.findOne({
          where: { installmentId }
        })
      } else {
        console.log('⚠️ No matching installment found in DB2. Skipping update.')
      }
    }

    // ✅ **Retrieve Updated Data**
    const updatedInstallment = await InstallmentIncome.findOne({
      where: { id: installmentId }
    })

    return res.status(200).json({
      status: true,
      message: 'Installment updated successfully',
      data: {
        updatedInstallmentDb1: updatedInstallment,
        updatedInstallmentDb2: updatedInstallmentDb2 // ✅ Only available if paymentMode is cash
      }
    })
  } catch (error) {
    console.error('❌ Error updating installment:', error)
    return res.status(500).json({ status: false, message: error.message })
  }
}
