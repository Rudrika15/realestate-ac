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

// create by and update by relations
// for user
User.hasOne(User, {
  as: "createByUser",
  foreignKey: "createBy",
});
User.hasOne(User, {
  as: "updateByUser",
  foreignKey: "updateBy",
});

// for user role
User.hasOne(UserRole, {
  as: "UserRoleCreateByUser",
  foreignKey: "createBy",
});
User.hasOne(UserRole, {
  as: "UserRoleUpdateByUser",
  foreignKey: "updateBy",
});

// for role
Role.hasOne(User, {
  as: "RoleCreateBy",
  foreignKey: "createBy",
});
Role.hasOne(User, {
  as: "RoleUpdateByUser",
  foreignKey: "updateBy",
});

// for role permission
RolePermission.hasOne(User, {
  as: "RolePermissionCreateBy",
  foreignKey: "createBy",
});
RolePermission.hasOne(User, {
  as: "RolePermissionUpdateByUser",
  foreignKey: "updateBy",
});

// for project unit
ProjectUnit.hasOne(User, {
  as: "ProjectUnitCreateBy",
  foreignKey: "createBy",
});
ProjectUnit.hasOne(User, {
  as: "ProjectUnitUpdateBy",
  foreignKey: "updateBy",
});

// for project stage transaction
ProjectStageTransaction.hasOne(User, {
  as: "ProjectStageTransactionCreateBy",
  foreignKey: "createBy",
});
ProjectStageTransaction.hasOne(User, {
  as: "ProjectStageTransactionUpdateBy",
  foreignKey: "updateBy",
});

// for project stage
ProjectStage.hasOne(User, {
  as: "ProjectStageCreateBy",
  foreignKey: "createBy",
});
ProjectStage.hasOne(User, {
  as: "ProjectStageUpdateBy",
  foreignKey: "updateBy",
});

// for project partner
ProjectPartner.hasOne(User, {
  as: "ProjectPartnerCreateBy",
  foreignKey: "createBy",
});
ProjectPartner.hasOne(User, {
  as: "ProjectPartnerUpdateBy",
  foreignKey: "updateBy",
});

// for project
Project.hasOne(User, {
  as: "ProjectCreateBy",
  foreignKey: "createBy",
});
Project.hasOne(User, {
  as: "ProjectUpdateBy",
  foreignKey: "updateBy",
});

// for permission
Permission.hasOne(User, {
  as: "PermissionCreateBy",
  foreignKey: "createBy",
});
Permission.hasOne(User, {
  as: "PermissionUpdateBy",
  foreignKey: "updateBy",
});

// for partner
Partner.hasOne(User, {
  as: "PartnerCreateBy",
  foreignKey: "createBy",
});
Partner.hasOne(User, {
  as: "PartnerUpdateBy",
  foreignKey: "updateBy",
});

// for income Master
IncomeMaster.hasOne(User, {
  as: "IncomeMasterCreateBy",
  foreignKey: "createBy",
});
IncomeMaster.hasOne(User, {
  as: "IncomeMasterUpdateBy",
  foreignKey: "updateBy",
});

// for income head
IncomeHead.hasOne(User, {
  as: "IncomeHeadCreateBy",
  foreignKey: "createBy",
});
IncomeHead.hasOne(User, {
  as: "IncomeHeadUpdateBy",
  foreignKey: "updateBy",
});

// for income details
IncomeDetail.hasOne(User, {
  as: "IncomeDetailCreateBy",
  foreignKey: "createBy",
});
IncomeDetail.hasOne(User, {
  as: "IncomeDetailUpdateBy",
  foreignKey: "updateBy",
});

// for expanse Master
ExpenseMaster.hasOne(User, {
  as: "ExpenseMasterCreateBy",
  foreignKey: "createBy",
});
ExpenseMaster.hasOne(User, {
  as: "ExpenseMasterUpdateBy",
  foreignKey: "updateBy",
});

// for expense head
ExpenseHead.hasOne(User, {
  as: "ExpenseHeadCreateBy",
  foreignKey: "createBy",
});
ExpenseHead.hasOne(User, {
  as: "ExpenseHeadUpdateBy",
  foreignKey: "updateBy",
});

// for expense details
ExpenseDetail.hasOne(User, {
  as: "ExpenseDetailCreateBy",
  foreignKey: "createBy",
});
ExpenseDetail.hasOne(User, {
  as: "ExpenseDetailUpdateBy",
  foreignKey: "updateBy",
});

// for Customer Master
CustomerMaster.hasOne(User, {
  as: "CustomerMasterCreateBy",
  foreignKey: "createBy",
});
CustomerMaster.hasOne(User, {
  as: "CustomerMasterUpdateBy",
  foreignKey: "updateBy",
});

// for Booking payment terms details
BookingPaymentTermsDetail.hasOne(User, {
  as: "BookingPaymentTermsDetailCreateBy",
  foreignKey: "createBy",
});
BookingPaymentTermsDetail.hasOne(User, {
  as: "BookingPaymentTermsDetailUpdateBy",
  foreignKey: "updateBy",
});

// for booking payment terms
BookingPaymentTerms.hasOne(User, {
  as: "BookingPaymentTermsCreateBy",
  foreignKey: "createBy",
});
BookingPaymentTerms.hasOne(User, {
  as: "BookingPaymentTermsUpdateBy",
  foreignKey: "updateBy",
});

// for booking master
BookingMaster.hasOne(User, {
  as: "BookingMasterCreateBy",
  foreignKey: "createBy",
});
BookingMaster.hasOne(User, {
  as: "BookingMasterUpdateBy",
  foreignKey: "updateBy",
});

// for booking customer
BookingCustomer.hasOne(User, {
  as: "BookingCustomerCreateBy",
  foreignKey: "createBy",
});
BookingCustomer.hasOne(User, {
  as: "BookingCustomerUpdateBy",
  foreignKey: "updateBy",
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

User.hasMany(Role, {
  as: "userRoles",
  foreignKey: "id",
});

// ------------------------------------------------------------//

// Sync the database

// sequelize
//   .sync({ alter: true })
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
};
