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

// User relations
User.belongsTo(User, { as: "createdByUser", foreignKey: "createdBy" });
User.belongsTo(User, { as: "updatedByUser", foreignKey: "updatedBy" });

// User Role relations
UserRole.belongsTo(User, { as: "user", foreignKey: "userId" });
UserRole.belongsTo(Role, { as: "role", foreignKey: "roleId" });
User.hasMany(UserRole, { as: "userRoles", foreignKey: "userId" });
Role.hasMany(UserRole, { as: "roleUsers", foreignKey: "roleId" });

// Role-Permission relations
Role.belongsToMany(Permission, {
  through: RolePermission,
  as: "permissions",
  foreignKey: "roleId",
});
Permission.belongsToMany(Role, {
  through: RolePermission,
  as: "roles",
  foreignKey: "permissionId",
});

// Project relations
Project.belongsTo(User, { as: "createdByUser", foreignKey: "createdBy" });
Project.belongsTo(User, { as: "updatedByUser", foreignKey: "updatedBy" });
Project.hasMany(ProjectStage, { as: "stages", foreignKey: "projectId" });

// ProjectStage relations
ProjectStage.belongsTo(Project, { as: "project", foreignKey: "projectId" });
ProjectStage.belongsTo(User, { as: "createdByUser", foreignKey: "createdBy" });
ProjectStage.belongsTo(User, { as: "updatedByUser", foreignKey: "updatedBy" });
ProjectStage.hasMany(ProjectStageTransaction, {
  as: "transactions",
  foreignKey: "projectStageId",
});

// ProjectStageTransaction relations
ProjectStageTransaction.belongsTo(ProjectStage, {
  as: "stage",
  foreignKey: "projectStageId",
});
ProjectStageTransaction.belongsTo(User, {
  as: "createdByUser",
  foreignKey: "createdBy",
});
ProjectStageTransaction.belongsTo(User, {
  as: "updatedByUser",
  foreignKey: "updatedBy",
});

// Partner relations
Partner.belongsTo(User, { as: "createdByUser", foreignKey: "createdBy" });
Partner.belongsTo(User, { as: "updatedByUser", foreignKey: "updatedBy" });
Partner.belongsToMany(Project, {
  through: ProjectPartner,
  as: "projects",
  foreignKey: "partnerId",
});

// ProjectPartner relations
ProjectPartner.belongsTo(Project, { as: "project", foreignKey: "projectId" });
ProjectPartner.belongsTo(Partner, { as: "partner", foreignKey: "partnerId" });

// Booking relations
BookingMaster.belongsTo(User, { as: "createdByUser", foreignKey: "createdBy" });
BookingMaster.belongsTo(User, { as: "updatedByUser", foreignKey: "updatedBy" });
BookingMaster.hasMany(BookingCustomer, {
  as: "customers",
  foreignKey: "bookingMasterId",
});

// Income relations
IncomeMaster.belongsTo(User, { as: "createdByUser", foreignKey: "createdBy" });
IncomeMaster.belongsTo(User, { as: "updatedByUser", foreignKey: "updatedBy" });
IncomeMaster.hasMany(IncomeDetail, {
  as: "details",
  foreignKey: "incomeMasterId",
});

// Expense relations
ExpenseMaster.belongsTo(User, { as: "createdByUser", foreignKey: "createdBy" });
ExpenseMaster.belongsTo(User, { as: "updatedByUser", foreignKey: "updatedBy" });
// ExpenseMaster.hasMany(ExpenseDetail, {
//   as: "details",
//   foreignKey: "expenseMasterId",
// });
// ExpenseDetail.belongsTo(ExpenseMaster, {
//   as: "expense",
//   foreignKey: "expenseMasterId",
// });

// Broker relations
Broker.belongsTo(User, { as: "createdByUser", foreignKey: "createdBy" });
Broker.belongsTo(User, { as: "updatedByUser", foreignKey: "updatedBy" });

// Sync the database
sequelize
  .sync({ alter: true })
  .then(() => console.log("All models synced"))
  .catch((err) => console.log(err));

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
};
