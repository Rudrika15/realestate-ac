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

exports.storePermission = async (req, res) => {
  try {
    const { permission } = req.body;
    const userId = req.userId;

    // Validate input
    if (!permission) {
      return res.status(400).json({
        status: false,
        message: "Permission is required in the request body",
      });
    }

    // Check if permission already exists
    const existingPermission = await Permissions.findOne({
      where: { permissionName: permission },
    });
    if (existingPermission) {
      return res.status(200).json({
        status: false,
        message: "Permission already exists",
      });
    }

    const slug = permission;
    // Create permission
    const newPermission = await Permissions.create({
      permissionName: permission,
      createdBy: userId,
      updatedBy: userId,
      slug: slug,
    });

    return res.status(201).json({
      status: true,
      message: "Permission added successfully",
      data: newPermission,
    });
  } catch (err) {
    // Log the error for debugging (optional)
    console.error("Error in storePermission:", err);

    return res.status(500).json({
      status: false,
      message: "An error occurred while adding the permission",
      error: err.message,
    });
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
exports.deletePermission = async (req, res) => {
  try {
    const { id } = req.params;
    const permission = await Permissions.findOne({ where: { id } });
    if (!permission) {
      return res.status(200).json({
        status: false,
        message: "Permission not found",
      });
    }
    await permission.destroy();
    return res.json({
      status: true,
      message: "Permission deleted successfully",
    });
  } catch (err) {
    return res.status(500).json({ status: false, error: err.message });
  }
};
