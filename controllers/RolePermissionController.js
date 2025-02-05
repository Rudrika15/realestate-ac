const { Permission, Role, RolePermission } = require("../models");
const rolePermission = require("../models/RolePermission");

exports.getRolehasPermission = async (req, res) => {
  try {
    const { id } = req.params;
    const rolehasPermission = await Role.findOne({
      where: { id: id },
      include: [
        {
          model: Permission,
          as: "permissions",
          attributes: ["permissionName", "slug"],
          through: { attributes: [] }, // Exclude join table data if not needed
        },
      ],
    });

    return res.json({
      status: true,
      message: "Role has Permission fetched successfully",
      data: rolehasPermission,
    });
  } catch (err) {
    return res.status(500).json({ status: false, error: err.message });
  }
};
exports.storeRoleHasPermission = async (req, res) => {
  try {
    const { roleName, permissionIds } = req.body;
    const userId = req.userId;

    // Validate input
    if (!roleName) {
      return res.status(400).json({
        status: false,
        message: "Role name is required",
      });
    }

    if (!Array.isArray(permissionIds) || permissionIds.length === 0) {
      return res.status(400).json({
        status: false,
        message: "Permission IDs must be a non-empty array",
      });
    }

    // Create the role in the Role model
    const role = await Role.create({
      role_name: roleName,
      createdBy: userId,
      updatedBy: userId,
    });

    // Extract role ID
    const roleId = role.id;

    // Prepare data for bulk creation
    const rolePermissions = permissionIds.map((permissionId) => ({
      permission: permissionId,
      role: roleId,
      createdBy: userId,
      updatedBy: userId,
    }));

    // Bulk create role permissions
    await RolePermission.bulkCreate(rolePermissions);

    return res.status(201).json({
      status: true,
      message: "Role with permissions added successfully",
    });
  } catch (err) {
    console.error("Error in storeRoleHasPermission:", err);
    return res.status(500).json({
      status: false,
      message: "An error occurred while adding the role with permissions",
      error: err.message,
    });
  }
};
