const { db1, db2 } = require("../config/database");

// Import all models
const { User } = require('./User')
const { Role } = require('./Role')
const { Permission } = require('./Permission')
const { RolePermission } = require('./RolePermission')
const { UserRole } = require('./UserRole')
const { Project } = require('./Project')
const { ProjectUnit } = require('./ProjectUnit')
const { ProjectStage } = require('./ProjectStage')
const { ProjectStageTransaction } = require('./ProjectStageTransaction')
const { Partner, Partner2 } = require('./Partner')
const { ProjectPartner } = require('./ProjectPartner')
const { CustomerMaster } = require('./CustomerMaster')
const { BookingMaster } = require('./BookingMaster')
const { BookingCustomer } = require('./BookingCustomer')
const { BookingPaymentTerms } = require('./BookingPaymentTerms')
const { BookingPaymentTermsDetail } = require('./BookingPaymentTermsDetail')
const { ExpenseHead } = require('./ExpenseHead')
const { ExpenseMaster } = require('./ExpenseMaster')
const { ExpenseDetail, ExpenseDetail2 } = require('./ExpenseDetail')
const { IncomeHead } = require('./IncomeHead')
const { IncomeMaster, IncomeMaster2 } = require('./IncomeMaster')
const { IncomeDetail, IncomeDetail2 } = require('./IncomeDetail')
const { Broker } = require('./Broker')
const { PartnerIncomeDb1, PartnerIncomeDb2 } = require('./PartnerIncome')
const { ScrapIncome1, ScrapIncome2 } = require('./ScrapIncome')
const { Income1, Income2 } = require('./Income')
const { InstallmentIncome, InstallmentIncome2 } = require('./IncomeInstallment')
const { UserProject } = require('./UserProject')
const { LoginCount } = require('./LoginCount')

// for user

User.hasOne(User, {
  as: "createdByUser",
  foreignKey: "createdBy",
});
User.hasOne(User, {
  as: "updatedByUser",
  foreignKey: "updatedBy",
});

// for user role
User.hasOne(UserRole, {
  as: "UserRolecreatedByUser",
  foreignKey: "createdBy",
});

User.hasOne(UserRole, {
  as: "UserRoleupdatedByUser",
  foreignKey: "updatedBy",
});

// for role

Role.hasOne(User, {
  as: "RolecreatedBy",
  foreignKey: "createdBy",
});
Role.hasOne(User, {
  as: "RoleupdatedByUser",
  foreignKey: "updatedBy",
});

// for role permission
RolePermission.hasOne(User, {
  as: "RolePermissioncreatedBy",
  foreignKey: "createdBy",
});
RolePermission.hasOne(User, {
  as: "RolePermissionupdatedByUser",
  foreignKey: "updatedBy",
});

// for project unit
ProjectUnit.hasOne(User, {
  as: "ProjectUnitcreatedBy",
  foreignKey: "createdBy",
});
ProjectUnit.hasOne(User, {
  as: "ProjectUnitupdatedBy",
  foreignKey: "updatedBy",
});

// for project stage transaction
ProjectStageTransaction.hasOne(User, {
  as: "ProjectStageTransactioncreatedBy",
  foreignKey: "createdBy",
});
ProjectStageTransaction.hasOne(User, {
  as: "ProjectStageTransactionupdatedBy",
  foreignKey: "updatedBy",
});

// for project stage
ProjectStage.belongsTo(User, {
  as: "ProjectStagecreatedBy",
  foreignKey: "createdBy",
});
ProjectStage.belongsTo(User, {
  as: "ProjectStageupdatedBy",
  foreignKey: "updatedBy",
});

// for project partner
ProjectPartner.belongsTo(User, {
  as: "ProjectPartnercreatedBy",
  foreignKey: "createdBy",
});
ProjectPartner.belongsTo(User, {
  as: "ProjectPartnerupdatedBy",
  foreignKey: "updatedBy",
});
// User.hasMany(Partner, { as: "CreatedPartners", foreignKey: "createdBy" });
// User.hasMany(Partner, { as: "UpdatedPartners", foreignKey: "updatedBy" });

// for project
Project.belongsTo(User, {
  as: "ProjectcreatedBy",
  foreignKey: "createdBy",
});
Project.belongsTo(User, {
  as: "ProjectupdatedBy",
  foreignKey: "updatedBy",
});

// partner with project relations
ProjectPartner.belongsTo(Project, {
  as: "project",
  foreignKey: "projectId",
});

// ✅ OLD Many-to-Many Relationship (Keep old aliases)
Project.belongsToMany(Partner, {
  through: ProjectPartner,
  foreignKey: 'projectId',
  as: 'partners'
})

Partner.belongsToMany(Project, {
  through: ProjectPartner,
  foreignKey: "partnerId",
  as: "projects",
});

// ✅ NEW Many-to-Many Relationship (Use new aliases)
Project.belongsToMany(Partner2, {
  through: ProjectPartner,
  foreignKey: 'projectId',
  as: 'partnersNew' // ✅ Unique alias for new relation
})

Partner2.belongsToMany(Project, {
  through: ProjectPartner,
  foreignKey: 'partnerId',
  as: 'projectsNew' // ✅ Unique alias for new relation
})

ProjectPartner.belongsToMany(Project, {
  through: Partner,
  as: 'projects',
  foreignKey: 'partnerId'
})

Partner.belongsTo(ProjectPartner, {
  as: "partner",
  foreignKey: "partnerId",
});

ProjectPartner.hasMany(Partner, {
  as: "ProjectPartners",
  foreignKey: "id",
});

Partner.belongsTo(Project, {
  as: "ProjectProject",
  foreignKey: "projectId",
});

// for permission
Permission.hasOne(User, {
  as: "PermissioncreatedBy",
  foreignKey: "createdBy",
});
Permission.hasOne(User, {
  as: "PermissionupdatedBy",
  foreignKey: "updatedBy",
});

// for partner
Partner.belongsTo(User, {
  as: "PartnercreatedBy",
  foreignKey: "createdBy",
});
Partner.belongsTo(User, {
  as: "PartnerupdatedBy",
  foreignKey: "updatedBy",
});

// for income Master
IncomeMaster.hasOne(User, {
  as: "IncomeMastercreatedBy",
  foreignKey: "createdBy",
});
IncomeMaster.hasOne(User, {
  as: "IncomeMasterupdatedBy",
  foreignKey: "updatedBy",
});
IncomeMaster2.hasOne(User, {
  as: "IncomeMastercreatedBy",
  foreignKey: "createdBy",
});
IncomeMaster2.hasOne(User, {
  as: "IncomeMasterupdatedBy",
  foreignKey: "updatedBy",
});

// for income head
IncomeHead.hasOne(User, {
  as: "IncomeHeadcreatedBy",
  foreignKey: "createdBy",
});
IncomeHead.hasOne(User, {
  as: "IncomeHeadupdatedBy",
  foreignKey: "updatedBy",
});

Income1.belongsTo(IncomeHead, { foreignKey: "incomeHeadId", as: "IncomeHead" });
Income2.belongsTo(IncomeHead, { foreignKey: "incomeHeadId", as: "IncomeHead" });

IncomeDetail.belongsTo(User, {
  as: "IncomeDetailCreatedBy",
  foreignKey: "createdBy",
});

IncomeDetail.belongsTo(User, {
  as: "IncomeDetailUpdatedBy",
  foreignKey: "updatedBy",
});

IncomeDetail2.belongsTo(User, {
  as: "IncomeDetail2CreatedBy",
  foreignKey: "createdBy",
});

IncomeDetail2.belongsTo(User, {
  as: "IncomeDetail2UpdatedBy",
  foreignKey: "updatedBy",
});

// for expanse Master
ExpenseMaster.hasOne(User, {
  as: "ExpenseMastercreatedBy",
  foreignKey: "createdBy",
});
ExpenseMaster.hasOne(User, {
  as: "ExpenseMasterupdatedBy",
  foreignKey: "updatedBy",
});

// for expense head
ExpenseHead.hasOne(User, {
  as: "ExpenseHeadcreatedBy",
  foreignKey: "createdBy",
});
ExpenseHead.hasOne(User, {
  as: "ExpenseHeadupdatedBy",
  foreignKey: "updatedBy",
});

ExpenseDetail.belongsTo(ExpenseMaster, {
  foreignKey: "expenseMasterId",
  as: "ExpenseMaster",
});
ExpenseDetail2.belongsTo(ExpenseMaster, {
  foreignKey: "expenseMasterId",
  as: "ExpenseMaster2",
});
// ExpenseDetail.belongsTo(ExpenseHead, {
//   foreignKey: 'expenseHeadId',
//   as: 'expenseHead'
// })

// ExpenseDetail2.belongsTo(ExpenseHead, {
//   foreignKey: 'expenseHeadId',
//   as: 'expenseHead2' // ✅ Use a unique alias
// })

// for Customer Master
CustomerMaster.hasOne(User, {
  as: "CustomerMastercreatedBy",
  foreignKey: "createdBy",
});
CustomerMaster.hasOne(User, {
  as: "CustomerMasterupdatedBy",
  foreignKey: "updatedBy",
});

// for Booking payment terms details
BookingPaymentTermsDetail.hasOne(User, {
  as: "BookingPaymentTermsDetailcreatedBy",
  foreignKey: "createdBy",
});
BookingPaymentTermsDetail.hasOne(User, {
  as: "BookingPaymentTermsDetailupdatedBy",
  foreignKey: "updatedBy",
});

// for booking payment terms
BookingPaymentTerms.hasOne(User, {
  as: "BookingPaymentTermscreatedBy",
  foreignKey: "createdBy",
});
BookingPaymentTerms.hasOne(User, {
  as: "BookingPaymentTermsupdatedBy",
  foreignKey: "updatedBy",
});

// for booking master
BookingMaster.hasOne(User, {
  as: "BookingMastercreatedBy",
  foreignKey: "createdBy",
});
BookingMaster.hasOne(User, {
  as: "BookingMasterupdatedBy",
  foreignKey: "updatedBy",
});

// for booking customer
BookingCustomer.hasOne(User, {
  as: "BookingCustomercreatedBy",
  foreignKey: "createdBy",
});
BookingCustomer.hasOne(User, {
  as: "BookingCustomerupdatedBy",
  foreignKey: "updatedBy",
});

// ------------------------------------------------------------//
// user role relation
UserRole.belongsTo(User, {
  as: "user",
  foreignKey: "userId",
});

UserRole.belongsTo(Role, {
  as: "role",
  foreignKey: "roleId",
});

Role.belongsToMany(Permission, {
  through: RolePermission,
  as: "permissions",
  foreignKey: "role",
});

Permission.belongsToMany(Role, {
  through: RolePermission,
  as: "roles",
  foreignKey: "permission",
});

User.belongsToMany(Role, {
  through: UserRole,
  as: "userRoles",
  foreignKey: "userId",
});

Role.belongsToMany(User, {
  through: UserRole,
  as: "users",
  foreignKey: "roleId",
});

// broker and user relations

Broker.belongsTo(User, {
  as: "BrokercreatedBy",
  foreignKey: "createdBy",
});
Broker.belongsTo(User, {
  as: "BrokerupdatedBy",
  foreignKey: "updatedBy",
});

// projectstage and user relations

ProjectStage.belongsTo(Project, {
  as: "Project",
  foreignKey: "projectId",
});

ProjectStage.hasMany(ProjectStageTransaction, {
  as: "transactions",
  foreignKey: "projectStageId",
});
ProjectStageTransaction.belongsTo(ProjectStage, {
  as: "stage",
  foreignKey: "projectStageId",
});

Role.belongsToMany(Permission, {
  through: RolePermission,
  as: "Permissions",
  foreignKey: "role",
});
Permission.belongsToMany(Role, {
  through: RolePermission,
  as: "Roles",
  foreignKey: "permission",
});

// expense head and user relations

// ExpenseMaster has many ExpenseDetails
ExpenseMaster.hasMany(ExpenseDetail, {
  as: "details", // Alias for the relationship
  foreignKey: "expenseMasterId",
});

ExpenseMaster.hasMany(ExpenseDetail2, {
  as: "details2", // Alias for the second instance
  foreignKey: "expenseMasterId",
});

// ExpenseDetail belongs to ExpenseMaster
// ExpenseDetail belongs to ExpenseMaster
ExpenseDetail.belongsTo(ExpenseMaster, {
  foreignKey: "expenseMasterId",
  as: "expenseMaster",
});
ExpenseDetail2.belongsTo(ExpenseMaster, {
  foreignKey: "expenseMasterId",
  as: "expenseMaster2",
});

// ExpenseDetail belongs to ExpenseHead
ExpenseDetail.belongsTo(ExpenseHead, {
  foreignKey: "expenseHeadId",
  as: "expenseHead",
});
ExpenseDetail2.belongsTo(ExpenseHead, {
  foreignKey: "expenseHeadId",
  as: "expenseHead2", // ✅ Unique alias to avoid conflicts
});

// ------------------------------------------------------------//
Project.hasMany(Income1, { foreignKey: "projectId" }); // ✅ Project has many Incomes
Income1.belongsTo(Project, { foreignKey: "projectId" }); // ✅ Income belongs to Project

// ✅ Define associations (AFTER all models are imported)
PartnerIncomeDb1.belongsTo(Income1, { foreignKey: "incomeId" });
PartnerIncomeDb1.belongsTo(Partner, { foreignKey: "partnerId" });
Partner.hasMany(PartnerIncomeDb1, { foreignKey: "partnerId" });
PartnerIncomeDb2.belongsTo(Income2, { foreignKey: "incomeId" });
PartnerIncomeDb2.belongsTo(Partner, { foreignKey: "partnerId" });
Partner.hasMany(PartnerIncomeDb2, { foreignKey: "partnerId" });

Income1.hasOne(ScrapIncome1, { foreignKey: "incomeId" });
ScrapIncome1.belongsTo(Income1, { foreignKey: "incomeId" });
Income2.hasOne(ScrapIncome2, { foreignKey: "incomeId" });
ScrapIncome2.belongsTo(Income2, { foreignKey: "incomeId" });

CustomerMaster.hasMany(BookingCustomer, {
  foreignKey: "customerId",
  as: "customers",
});
BookingCustomer.belongsTo(CustomerMaster, {
  foreignKey: "customerId",
  as: "customer",
});
BookingMaster.hasMany(BookingCustomer, {
  foreignKey: "bookingId",
  as: "customers",
});
BookingCustomer.belongsTo(BookingMaster, {
  foreignKey: "bookingId",
  as: "booking",
});
BookingMaster.hasMany(BookingPaymentTerms, {
  foreignKey: "bookingId",
  as: "paymentTerms",
});
BookingPaymentTerms.belongsTo(BookingMaster, {
  foreignKey: "bookingId",
  as: "booking",
});

// BookingMaster Model
BookingMaster.belongsTo(ProjectUnit, {
  foreignKey: "projectUnitId",
  as: "projectUnit",
});

// ProjectUnit Model (if needed)
ProjectUnit.hasOne(BookingMaster, {
  foreignKey: "projectUnitId", // `projectUnitId` in BookingMaster links to ProjectUnit
  as: "booking",
});

BookingPaymentTerms.hasMany(BookingPaymentTermsDetail, {
  foreignKey: "BookingPaymentTermsId",
  as: "paymentDetails",
});
BookingPaymentTermsDetail.belongsTo(BookingPaymentTerms, {
  foreignKey: "BookingPaymentTermsId",
  as: "paymentTerm",
});

const models = {
  db1,
  db2,
  User,
  Role,
  Permission,
  RolePermission,
  UserRole,
  Project,
  ProjectUnit,
  ProjectStage,
  ProjectStageTransaction,
  Partner,
  Partner2,
  ProjectPartner,
  CustomerMaster,
  BookingMaster,
  BookingCustomer,
  BookingPaymentTerms,
  BookingPaymentTermsDetail,
  ExpenseHead,
  ExpenseMaster,
  ExpenseDetail,
  ExpenseDetail2,
  IncomeHead,
  IncomeMaster,
  IncomeDetail,
  IncomeDetail2,
  Broker,
  PartnerIncomeDb1,
  PartnerIncomeDb2,
  ScrapIncome1,
  ScrapIncome2,
  Income1,
  Income2,
  InstallmentIncome,
  InstallmentIncome2,
  UserProject,
  LoginCount,
};

Object.values(models).forEach((model) => {
  if (model.associate) {
    model.associate(models);
  }
});

// Promise.all([
//   db1
//     .sync({ alter: false, force: false })
//     .then(() => console.log('✅ DB1 models synced successfully'))
//     .catch(err => console.error('❌ DB1 sync error:', err)),
//   db2
//     .sync({ alter: false, force: false })
//     .then(() => console.log('✅ DB2 models synced successfully'))
//     .catch(err => console.error('❌ DB2 sync error:', err))
// ]).catch(err => console.error('❌ Error in syncing models:', err))

module.exports = models;
