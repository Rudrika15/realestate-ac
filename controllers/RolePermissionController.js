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
