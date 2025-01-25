const { Permission, Role } = require("../models");
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
          attributes: ["permissionName"],
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
exports.storeRolehasPermission = async (req, res) => {
  try {
    const { roleName, permissionIds } = req.body;
    const userId = req.userId;

    if (!roleName) {
      return res.status(200).json({
        status: false,
        message: "roleName is required",
      });
    }

    if (
      !permissionIds ||
      !Array.isArray(permissionIds) ||
      permissionIds.length === 0
    ) {
      return res.status(200).json({
        status: false,
        message: "permissionIds must be a non-empty array",
      });
    }

    // Insert role in role model
    const role = await Role.create({
      role_name: roleName,
      createdBy: userId,
      updatedBy: userId,
    });

    // Get role id
    const roleId = role.id;

    // Create array of objects for bulkCreate
    const rolePermissions = permissionIds.map((permissionId) => ({
      permission: permissionId,
      role: roleId,
      createdBy: userId,
      updatedBy: userId,
    }));

    // Save multiple permissions in rolePermission model
    await rolePermission.bulkCreate(rolePermissions);

    return res.status(200).json({
      status: true,
      message: "Role with permissions added successfully",
    });
  } catch (err) {
    return res.status(500).json({ status: false, error: err.message });
  }
};
