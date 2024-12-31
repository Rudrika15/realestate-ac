const Permissions = require("../models/Permission");

exports.getPermissions = async (req, res) => {
  try {
    const permissions = await Permissions.findAll();

    return res.json({
      status: true,
      message: "Permissions fetched successfully",
      data: permissions,
    });
  } catch (err) {
    return res.status(500).json({ status: false, error: err.message });
  }
};

exports.getPermissionById = async (req, res) => {
  try {
    const { id } = req.params;
    const permission = await Permissions.findOne({ where: { id } });
    if (!permission) {
      return res.status(404).json({ message: "Permission not found" });
    }
    return res.json({
      status: true,
      message: "Permission fetched successfully",
      data: permission,
    });
  } catch (err) {
    return res.status(500).json({ status: false, error: err.message });
  }
};

exports.updatePermission = async (req, res) => {
  try {
    const { id } = req.params;
    const { permission } = req.body;

    if (!permission) {
      return res.status(400).json({
        status: false,
        message: "Permission is required in the request body",
      });
    }

    const permissions = await Permissions.findOne({ where: { id } });

    if (!permissions) {
      return res.status(404).json({
        status: false,
        message: "Permission not found",
      });
    }
    permissions.permissionName = permission;
    await permissions.save();

    return res.status(200).json({
      status: true,
      message: "Permission updated successfully",
      data: permissions,
    });
  } catch (err) {
    return res.status(500).json({
      status: false,
      message: "An error occurred while updating the permission",
      error: err.message,
    });
  }
};
