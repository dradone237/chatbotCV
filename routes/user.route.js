const express = require("express");

let router = express.Router();
const userCtlr = require("../controllers/user.controller");
router.put("", userCtlr.upload, userCtlr.createUser);

module.exports = router;
