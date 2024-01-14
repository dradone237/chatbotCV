const jwt = require("jsonwebtoken");

const extractBearer = (authorization) => {
  if (typeof authorization != "string") {
    return false;
  }
  const matches = authorization.match(/(bearer)\s+(\S+)/i);

  return matches && matches[2];
};
const checktokenmaddleware = (req, res, next) => {
  const token =
    req.headers.authorization && extractBearer(req.headers.authorization);
  if (!token) {
    return res.status(401).json({ message: "ho le petit malin" });
  }

  jwt.verify(token, process.env.JWT_SECRET, (error, tokendecoded) => {
    if (error) {
      return res.status(401).json({ message: "BAD TOKEN" });
    }
    next();
  });
};

module.exports = checktokenmaddleware;
