const jwt = require("jsonwebtoken");

const authenticateToken = (req, res, next) => {
  const token = req.headers["authorization"]?.split(" ")[1]; // Assuming "Bearer <token>"
  if (!token) {
    return res.status(401).json({
      status: false,
      message: "Access token is missing or invalid",
    });
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET); // Replace with your JWT secret
    req.userId = decoded.userId; // Attach userId to request
    next();
  } catch (error) {
    return res.status(403).json({
      status: false,
      message: "Invalid or expired token",
    });
  }
};

module.exports = authenticateToken;
