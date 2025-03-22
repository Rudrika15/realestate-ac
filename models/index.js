const sequelize = require("../config/database");
const User = require("./User");
const Role = require("./Role");
const Permission = require("./Permission");
const RolePermission = require("./RolePermission");
const UserRole = require("./UserRole");
const Project = require("./Project");
const ProjectUnit = require("./ProjectUnit");
const ProjectStage = require("./ProjectStage");
const ProjectStageTransaction = require("./ProjectStageTransaction");
const Partner = require("./Partner");
const ProjectPartner = require("./ProjectPartner");
const CustomerMaster = require("./CustomerMaster");
const BookingMaster = require("./BookingMaster");
const BookingCustomer = require("./BookingCustomer");
const BookingPaymentTerms = require("./BookingPaymentTerms");
const BookingPaymentTermsDetail = require("./BookingPaymentTermsDetail");
const ExpenseHead = require("./ExpenseHead");
const ExpenseMaster = require("./ExpenseMaster");
const ExpenseDetail = require("./ExpenseDetail");
const IncomeHead = require("./IncomeHead");
const IncomeMaster = require("./IncomeMaster");
const IncomeDetail = require("./IncomeDetail");
const Broker = require("./Broker");
const PartnerIncome = require("./PartnerIncome");
const ScrapIncome = require("./ScrapIncome");
const Income = require("./Income");
const IncomeInstallment = require("./IncomeInstallment");
const UserProject = require("./UserProject");
const IncomeBookingDetail = require("./IncomeBookingDetail");
const IncomeBooking = require("./IncomeBooking");
// create by and update by relations
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

Project.belongsToMany(Partner, {
  through: ProjectPartner,
  as: "partners",
  foreignKey: "projectId",
});

Partner.belongsToMany(Project, {
  through: ProjectPartner,
  as: "projects",
  foreignKey: "partnerId",
});

// ProjectPartner.belongsToMany(Project, {
//   through: Partner,
//   as: "projects",
//   foreignKey: "partnerId",
// });

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

// for income head
IncomeHead.hasOne(User, {
  as: "IncomeHeadcreatedBy",
  foreignKey: "createdBy",
});
IncomeHead.hasOne(User, {
  as: "IncomeHeadupdatedBy",
  foreignKey: "updatedBy",
});

Income.belongsTo(IncomeHead, { foreignKey: "incomeHeadId", as: "IncomeHead" });

// for income details
IncomeDetail.hasOne(User, {
  as: "IncomeDetailcreatedBy",
  foreignKey: "createdBy",
});
IncomeDetail.hasOne(User, {
  as: "IncomeDetailupdatedBy",
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

// for expense details
ExpenseDetail.hasOne(User, {
  as: "ExpenseDetailcreatedBy",
  foreignKey: "createdBy",
});
ExpenseDetail.hasOne(User, {
  as: "ExpenseDetailupdatedBy",
  foreignKey: "updatedBy",
});

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

ExpenseMaster.hasMany(ExpenseDetail, {
  as: "details", // Alias for the relationship
  foreignKey: "expenseMasterId", // Foreign key in ExpenseDetail
});

ExpenseDetail.belongsTo(ExpenseMaster, {
  foreignKey: "expenseMasterId", // Foreign key in ExpenseDetail
});

ExpenseDetail.belongsTo(ExpenseHead, {
  foreignKey: "expenseHeadId",
  as: "expenseHead",
});

// ------------------------------------------------------------//

Project.hasMany(Income, { foreignKey: "projectId" }); // Project has many Incomes
PartnerIncome.belongsTo(Income, { foreignKey: "incomeId" }); // PartnerIncome belongs to Income
PartnerIncome.belongsTo(Partner, { foreignKey: "partnerId" }); // PartnerIncome belongs to Partner
Partner.hasMany(PartnerIncome, { foreignKey: "partnerId" }); // Partner has many PartnerIncomes
Income.belongsTo(Project, { foreignKey: "projectId" });

Income.hasOne(sequelize.models.ScrapIncome, { foreignKey: "incomeId" });
ScrapIncome.belongsTo(sequelize.models.Income, { foreignKey: "incomeId" });

CustomerMaster.hasMany(BookingCustomer, {
  foreignKey: "customerId",
  as: "customers",
});
BookingCustomer.belongsTo(CustomerMaster, {
  foreignKey: "customerId",
  as: "customer",
});

// BookingMaster ↔ BookingCustomer (One-to-Many)
BookingMaster.hasMany(BookingCustomer, {
  foreignKey: "bookingId",
  as: "customers",
});
BookingCustomer.belongsTo(BookingMaster, {
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

// BookingMaster -> BookingPaymentTerms
BookingMaster.hasMany(BookingPaymentTerms, {
  foreignKey: "bookingId",
  as: "paymentTerms",
});

BookingPaymentTerms.belongsTo(BookingMaster, {
  foreignKey: "bookingId",
  as: "booking",
});

// BookingPaymentTerms -> BookingPaymentTermsDetail
BookingPaymentTerms.hasMany(BookingPaymentTermsDetail, {
  foreignKey: "bookingPaymentTermsId",
  as: "paymentDetails",
});

BookingPaymentTermsDetail.belongsTo(BookingPaymentTerms, {
  foreignKey: "bookingPaymentTermsId",
  as: "paymentTerm",
});

// incomeBooking

IncomeBooking.hasMany(IncomeBookingDetail, {
  foreignKey: "incomeBookingId",
  as: "bookingDetails",
});
IncomeBookingDetail.belongsTo(IncomeBooking, {
  foreignKey: "incomeBookingId",
  as: "incomeBooking",
});

// Sync the database

// sequelize
//   .sync({ alter: false, force: true })
//   .then(() => console.log("All models synced"))
//   .catch((err) => console.log(err));

module.exports = {
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
  ProjectPartner,
  CustomerMaster,
  BookingMaster,
  BookingCustomer,
  BookingPaymentTerms,
  BookingPaymentTermsDetail,
  ExpenseHead,
  ExpenseMaster,
  ExpenseDetail,
  IncomeHead,
  IncomeMaster,
  IncomeDetail,
  Broker,
  PartnerIncome,
  ScrapIncome,
  Income,
  IncomeInstallment,
  UserProject,
  IncomeBooking,
  IncomeBookingDetail,
};
