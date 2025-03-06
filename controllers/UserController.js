const {
  User,
  Role,
  UserRole,
  Permission,
  UserProject,
  LoginCount,
} = require("../models");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const { Op } = require("sequelize");
const sequelize = require("../config/database");

exports.loginUser = async (req, res) => {
  try {
    const { userName, passcode } = req.body;

    if (!userName || !passcode) {
      return res
        .status(400)
        .json({ message: "userName and passcode are required" });
    }

    const user = await User.findOne({ where: { userName, isDeleted: false } });
    return user;
    if (!user) {
      return res.status(200).json({ message: "User not found" });
    }

    const isMatch = await bcrypt.compare(passcode, user.passcode);
    if (!isMatch) {
      return res.status(401).json({ message: "Invalid passcode" });
    }

    const jwtSecret = process.env.JWT_SECRET;
    if (!jwtSecret) {
      return res.status(500).json({ message: "JWT Secret not configured" });
    }

    const token = jwt.sign(
      { userId: user.id, name: user.name, role: user.role },
      jwtSecret,
      { expiresIn: "1h" }
    );

    const { passcode: _, ...userData } = user.toJSON();

    res.json({
      status: true,
      message: "Login successful",
      data: userData,
      token,
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: err.message });
  }
};

exports.storeUser = async (req, res) => {
  try {
    const { roles, passcode, authPasscode, userName, projectIds } = req.body;

    // Validate required fields
    const fields = { roles, passcode, userName, projectIds };
    for (const field in fields) {
      if (!fields[field]) {
        return res.json({
          status: false,
          message: `${field} is required.`,
        });
      }
    }

    if (!Array.isArray(roles) || roles.length === 0) {
      return res.json({
        status: false,
        message: "Roles must be a non-empty array.",
      });
    }

    if (!Array.isArray(projectIds) || projectIds.length === 0) {
      return res.json({
        status: false,
        message: "Project IDs must be a non-empty array.",
      });
    }

    const existingUser = await User.findOne({ where: { userName } });
    if (existingUser) {
      return res.json({
        status: false,
        message: "userName is already in use.",
      });
    }

    // Hash passwords
    let hashedAuthPasscode = null;
    const saltRounds = 10;
    const hashedPasscode = await bcrypt.hash(passcode, saltRounds);
    if (authPasscode) {
      hashedAuthPasscode = await bcrypt.hash(authPasscode, saltRounds);
    }

    // Create new user
    const newUser = await User.create({
      userName,
      passcode: hashedPasscode,
      authPasscode: hashedAuthPasscode,
    });

    // Store user-role relationships
    const roleInstances = await Role.findAll({
      where: { id: roles },
    });

    if (roleInstances.length !== roles.length) {
      return res.json({
        status: false,
        message: "One or more roles are invalid.",
      });
    }

    for (const role of roleInstances) {
      await sequelize.models.UserRole.create({
        userId: newUser.id,
        roleId: role.id,
      });
    }

    // Store user-project relationships (for multiple projects)
    const userProjects = projectIds.map((projectId) => ({
      userId: newUser.id,
      projectId: projectId,
    }));

    await sequelize.models.UserProject.bulkCreate(userProjects);

    // Generate JWT token
    const token = jwt.sign(
      { userId: newUser.id, userName: newUser.userName, roles },
      process.env.JWT_SECRET,
      { expiresIn: "1y" }
    );

    return res.status(201).json({
      status: true,
      message: "User added successfully",
      data: {
        id: newUser.id,
        userName: newUser.userName,
        roles,
        projectIds,
      },
      token,
    });
  } catch (err) {
    console.error("Error storing user:", err);
    res.status(500).json({
      status: false,
      message: "Internal server error",
      error: err.message,
    });
  }
};

exports.login = async (req, res) => {
  try {
    const { userName, passcode } = req.body;

    if (!userName) {
      return res
        .status(400)
        .json({ status: false, message: "Username is required" });
    }

    if (!passcode) {
      return res
        .status(400)
        .json({ status: false, message: "Passcode is required" });
    }

    const user = await User.findOne({
      where: { userName, isDeleted: 0 },
      include: [{ model: Role, as: "userRoles", attributes: ["role_name"] }],
    });

    if (!user) {
      return res.status(200).json({ status: false, message: "User not found" });
    }

    const isMatch = await bcrypt.compare(passcode, user.passcode);
    if (!isMatch) {
      return res
        .status(401)
        .json({ status: false, message: "Invalid passcode" });
    }

    const jwtSecret = process.env.JWT_SECRET;
    if (!jwtSecret) {
      return res
        .status(500)
        .json({ status: false, message: "JWT Secret not configured" });
    }

    const roleNames = user.userRoles.map((role) => role.role_name);
    const token = jwt.sign(
      { userId: user.id, name: user.name, roles: roleNames },
      jwtSecret,
      {
        expiresIn: "1h",
      }
    );

    const userData = {
      id: user.id,
      name: user.name,
      userName: user.userName,
      roles: roleNames,
    };

    const today = new Date().toLocaleString("en-GB", {
      timeZone: "Asia/Kolkata",
    });
    const formattedToday = today.split(",")[0].split("/").reverse().join("-");

    console.log("Today's Date (IST):", formattedToday);
    // Check if login count exceeds 5
    const count = await LoginCount.findOne({ where: { userId: user.id } });
    if (count && count.loginCount > 4) {
      if (count && count.date == formattedToday) {
        return res.status(200).json({
          status: false,
          message: "Something went wrong please try again letter",
        });
      }
    }

    // Manage login count
    if (!count) {
      await LoginCount.create({
        userId: user.id,
        loginCount: 1,
        date: formattedToday,
      });
    } else {
      const lastLoginDate = new Date(count.date).toISOString().split("T")[0];

      if (lastLoginDate === formattedToday) {
        await LoginCount.update(
          { loginCount: count.loginCount + 1 },
          { where: { userId: user.id } }
        );
      } else {
        await LoginCount.update(
          { loginCount: 1, date: formattedToday },
          { where: { userId: user.id } }
        );
      }
    }

    return res.status(200).json({
      status: true,
      message: "Login successful",
      data: userData,
      token,
    });
  } catch (error) {
    console.error("Error during login:", error);
    return res
      .status(500)
      .json({ status: false, message: "Internal Server Error" });
  }
};

exports.getUser = async (req, res) => {
  try {
    const { page = 1, limit = 10, search } = req.query;

    const parsedLimit = parseInt(limit);
    const parsedPage = parseInt(page);
    const offset = (parsedPage - 1) * parsedLimit;

    let searchCondition = {};
    if (search) {
      searchCondition = {
        [Op.or]: [
          { name: { [Op.like]: `%${search}%` } },
          { userName: { [Op.like]: `%${search}%` } },
          { "$userRoles.role_name$": { [Op.like]: `%${search}%` } },
        ],
      };
    }

    const { count, rows: users } = await User.findAndCountAll({
      where: [searchCondition, { isDeleted: 0 }],
      limit: parsedLimit,
      offset,
      distinct: true,
      include: [
        {
          model: Role,
          as: "userRoles",
          attributes: ["role_name"],
          through: { attributes: [] },
        },
        {
          model: User,
          as: "createdByUser",
          attributes: ["userName"],
        },
        {
          model: User,
          as: "updatedByUser",
          attributes: ["userName"],
        },
      ],
    });

    const userData = users.map((user) => {
      const userJSON = user.toJSON();
      return {
        ...userJSON,
        userRoles: userJSON.userRoles.map((role) => role.role_name),
      };
    });

    const totalPages = Math.ceil(count / parsedLimit);

    res.json({
      status: true,
      message: "Users fetched successfully",
      pagination: {
        total: count,
        page: parsedPage,
        limit: parsedLimit,
        totalPages,
      },
      data: userData,
    });
  } catch (err) {
    console.error("Error fetching users:", err);
    res.status(500).json({ status: false, error: err.message });
  }
};

exports.getUserById = async (req, res) => {
  try {
    const { id } = req.params;

    const user = await User.findOne({
      where: { id },
      include: {
        model: Role,
        attributes: ["role_name"],
      },
    });

    if (!user) {
      return res.status(200).json({ status: false, message: "User not found" });
    }

    res.json({
      status: true,
      message: "User fetched successfully",
      data: user,
    });
  } catch (err) {
    res.status(500).json({ status: false, error: err.message });
  }
};

exports.updateUser = async (req, res) => {
  try {
    const { id } = req.params;
    const { userName } = req.body;

    const user = await User.findOne({ where: { id } });

    if (!user) {
      return res.status(200).json({ status: false, message: "User not found" });
    }

    user.userName = userName;
    await user.save();
    res.json({
      status: true,
      message: "User updated successfully",
      data: user,
    });
  } catch (err) {
    res.status(500).json({ status: false, error: err.message });
  }
};
exports.deleteUser = async (req, res) => {
  try {
    const { id } = req.params;

    const user = await User.findOne({ where: { id } });
    if (!user) {
      return res.status(200).json({ status: false, message: "User not found" });
    }

    await user.update({
      isDeleted: true,
    });

    return res.json({ status: true, message: "User deleted successfully" });
  } catch (err) {
    res.status(500).json({ status: false, error: err.message });
  }
};

exports.rolesWisePermissions = async (req, res) => {
  try {
    const userId = req.userId;

    const userRoles = await UserRole.findAll({
      where: { userId },
      include: [
        {
          model: Role,
          as: "role",
          include: [
            {
              model: Permission,
              as: "permissions",
              attributes: ["id", "permissionName", "slug"], // Ensure slug is selected
            },
          ],
        },
      ],
    });

    const permissions = userRoles
      .map((userRole) => userRole.role.permissions)
      .flat()
      .map((permission) => ({
        id: permission.id,
        name: permission.permissionName,
        slug: permission.slug, // Include slug in response
      }));

    res.json({
      status: true,
      message: "Permissions fetched successfully",
      data: permissions,
    });
  } catch (err) {
    res.status(500).json({ status: false, error: err.message });
  }
};

exports.deletedUsers = async (req, res) => {
  try {
    const deletedUsers = await User.findAll({ where: { isDeleted: true } });
    return res.json({
      status: true,
      message: "Deleted users fetched successfully",
      data: deletedUsers,
    });
  } catch (err) {
    return res.status(500).json({ status: false, error: err.message });
  }
};

exports.restoreUser = async (req, res) => {
  try {
    const { id } = req.params;
    const user = await User.findOne({ where: { id } });
    if (!user) {
      return res.status(200).json({ status: false, message: "User not found" });
    }
    await user.update({ isDeleted: false });

    return res.json({ status: true, message: "User restored successfully" });
  } catch (err) {
    return res.status(500).json({ status: false, error: err.message });
  }
};
