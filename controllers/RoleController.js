const { User, Permission, RolePermission } = require("../models");
const Role = require("./../models/Role");
// Controller to store a new role
exports.storeRole = async (req, res) => {
  try {
    const { role_name } = req.body;

    if (!role_name) {
      return res.status(200).json({
        status: false,
        message: "role_name is required",
      });
    }

    const role = new Role({ role_name });
    await role.save();

    return res.json({
      status: true,
      message: "Role added successfully",
      data: role,
    });
  } catch (err) {
    return res.status(500).json({
      status: false,
      message: "An error occurred while adding the role",
      error: err.message,
    });
  }
};

exports.getRole = async (req, res) => {
  try {
    const roles = await Role.findAll({
      include: [
        {
          model: User,
          as: "RolecreatedBy",
          attributes: ["userName"],
        },
        {
          model: User,
          as: "RoleupdatedByUser",
          attributes: ["userName"],
        },
        {
          model: Permission, // Include the Permission model
          as: "Permissions", // Alias used in Role associations
          through: {
            model: RolePermission, // The pivot table
            as: "RolePermission", // Alias for the pivot table
            attributes: [], // Exclude pivot attributes if not needed
          },
          attributes: ["id", "permissionName"], // Attributes of the Permission model
        },
      ],
    });

    return res.json({
      status: true,
      message: "Roles fetched successfully",
      data: roles,
    });
  } catch (err) {
    return res.status(500).json({ status: false, error: err.message });
  }
};

exports.getRoleById = async (req, res) => {
  try {
    const { id } = req.params;
    const role = await Role.findOne({ where: { id } });
    if (!role) {
      return res.status(404).json({ message: "Role not found" });
    }
    return res.json({
      status: true,
      message: "Role fetched successfully",
      data: role,
    });
  } catch (err) {
    return res.status(500).json({ status: false, error: err.message });
  }
};

exports.updateRole = async (req, res) => {
  try {
    const { id } = req.params;
    const { role_name } = req.body;
    if (!role_name) {
      return res.status(200).json({
        status: false,
        message: "role name is required",
      });
    }
    const role = await Role.findOne({ where: { id } });
    if (!role) {
      return res.status(200).json({
        status: false,
        message: "Role not found",
      });
    }
    role.role_name = role_name;
    await role.save();
    return res.json({
      status: true,
      message: "Role updated successfully",
      data: role,
    });
  } catch (err) {
    return res.status(500).json({ status: false, error: err.message });
  }
};
exports.deleteRole = async (req, res) => {
  try {
    const { id } = req.params;
    const role = await Role.findOne({ where: { id } });
    if (!role) {
      return res.status(200).json({
        status: false,
        message: "Role not found",
      });
    }
    await role.destroy();
    return res.json({
      status: true,
      message: "Role deleted successfully",
    });
  } catch (err) {
    return res.status(500).json({ status: false, error: err.message });
  }
};
