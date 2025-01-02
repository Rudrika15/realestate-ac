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
ProjectStage.hasOne(User, {
  as: "ProjectStagecreatedBy",
  foreignKey: "createdBy",
});
ProjectStage.hasOne(User, {
  as: "ProjectStageupdatedBy",
  foreignKey: "updatedBy",
});

// for project partner
ProjectPartner.hasOne(User, {
  as: "ProjectPartnercreatedBy",
  foreignKey: "createdBy",
});
ProjectPartner.hasOne(User, {
  as: "ProjectPartnerupdatedBy",
  foreignKey: "updatedBy",
});

// for project
Project.hasOne(User, {
  as: "ProjectcreatedBy",
  foreignKey: "createdBy",
});
Project.hasOne(User, {
  as: "ProjectupdatedBy",
  foreignKey: "updatedBy",
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
Partner.hasOne(User, {
  as: "PartnercreatedBy",
  foreignKey: "createdBy",
});
Partner.hasOne(User, {
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
// ------------------------------------------------------------//

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
};
