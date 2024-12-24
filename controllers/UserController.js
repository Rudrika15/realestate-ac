const { User, Role } = require("../models");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const { Op } = require("sequelize");

exports.loginUser = async (req, res) => {
  try {
    const { email, passcode } = req.body;

    if (!email || !passcode) {
      return res
        .status(400)
        .json({ message: "Email and passcode are required" });
    }

    const user = await User.findOne({ where: { email } });
    if (!user) {
      return res.status(200).json({ message: "User not found" });
    }

    const isMatch = await bcrypt.compare(passcode, user.passcode);
    if (!isMatch) {
      return res.status(401).json({ message: "Invalid passcode" });
    }

    // Ensure JWT_SECRET is present in environment variables
    const jwtSecret = process.env.JWT_SECRET;
    if (!jwtSecret) {
      return res.status(500).json({ message: "JWT Secret not configured" });
    }

    const token = jwt.sign(
      { userId: user.id, name: user.name, role: user.role },
      jwtSecret,
      { expiresIn: "1y" }
    );

    // Exclude the passcode from the user data
    const { passcode: _, ...userData } = user.toJSON();

    res.json({
      status: true,
      message: "Login successful",
      data: userData,
      token,
    });
  } catch (err) {
    console.error(err); // Log the error for debugging
    res.status(500).json({ error: err.message });
  }
};

exports.storeUser = async (req, res) => {
  try {
    const { name, role, passcode, email } = req.body;

    const fields = { name, role, passcode, email };
    for (const field in fields) {
      if (!fields[field]) {
        return res.json({
          status: false,
          message: `${field} is required.`,
        });
      }
    }

    // Check if the email is already taken
    const existingUser = await User.findOne({ where: { email } });
    if (existingUser) {
      return res.json({
        status: false,
        message: "Email is already in use.",
      });
    }

    // Hash the passcode
    const saltRounds = 10;
    const hashedPasscode = await bcrypt.hash(passcode, saltRounds);

    // Create the new user
    const newUser = await User.create({
      name,
      role,
      email,
      passcode: hashedPasscode,
    });

    // Generate a JWT token
    const token = jwt.sign(
      { userId: newUser.id, name: newUser.name, role: newUser.role },
      process.env.JWT_SECRET,
      { expiresIn: "1y" }
    );

    res.status(201).json({
      status: true,
      message: "User added successfully",
      data: {
        id: newUser.id,
        name: newUser.name,
        role: newUser.role,
        email: newUser.email,
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
    const { email, passcode } = req.body;

    // Validate input fields
    if (!email) {
      return res.status(400).json({
        status: false,
        message: "Email is required",
      });
    }

    if (!passcode) {
      return res.status(400).json({
        status: false,
        message: "Passcode is required",
      });
    }

    // Find user by email
    const user = await User.findOne({ where: { email } });

    if (!user) {
      return res.status(200).json({
        status: false,
        message: "User not found",
      });
    }

    // Check passcode validity
    const isMatch = await bcrypt.compare(passcode, user.passcode);
    if (!isMatch) {
      return res.status(401).json({
        status: false,
        message: "Invalid passcode",
      });
    }

    // Ensure JWT_SECRET is present in environment variables
    const jwtSecret = process.env.JWT_SECRET;
    if (!jwtSecret) {
      return res.status(500).json({
        status: false,
        message: "JWT Secret not configured",
      });
    }

    // Generate JWT token
    const token = jwt.sign(
      { userId: user.id, name: user.name, role: user.role },
      jwtSecret,
      { expiresIn: "15m" }
    );

    // Return user data and token
    const userData = {
      id: user.id,
      name: user.name,
      email: user.email,
      role: user.role,
    };

    return res.status(200).json({
      status: true,
      message: "Login successful",
      data: userData,
      token,
    });
  } catch (error) {
    console.error("Error during login:", error);
    return res.status(500).json({
      status: false,
      message: "Internal server error",
    });
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
          { email: { [Op.like]: `%${search}%` } },
          { "$Role.role_name$": { [Op.like]: `%${search}%` } },
        ],
      };
    }

    const { count, rows: users } = await User.findAndCountAll({
      where: searchCondition,
      limit: parsedLimit,
      offset,
      include: [
        {
          model: Role,
          as: "userRoles",
          attributes: ["role_name"],
        },
        {
          model: User,
          as: "createByUser",
          attributes: ["userName"],
        },
        {
          model: User,
          as: "updateByUser",
          attributes: ["userName"],
        },
      ],
    });

    // Construct pagination info
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
      data: users,
    });
  } catch (err) {
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
    const { name, email, role } = req.body;
    if (!name) {
      return res
        .status(200)
        .json({ status: false, message: "Name is required" });
    }
    if (!email) {
      return res
        .status(200)
        .json({ status: false, message: "Email is required" });
    }
    if (!role) {
      return res
        .status(200)
        .json({ status: false, message: "Role is required" });
    }
    const user = await User.findOne({ where: { id } });
    if (!user) {
      return res.status(200).json({ status: false, message: "User not found" });
    }

    user.name = name;
    user.email = email;
    user.role = role;

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

    await user.destroy();

    res.json({ status: true, message: "User deleted successfully" });
  } catch (err) {
    res.status(500).json({ status: false, error: err.message });
  }
};
