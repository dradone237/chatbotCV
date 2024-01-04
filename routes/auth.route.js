const express = require("express");
const authctl = require("../controllers/auth.controller");
let router = express.Router();

router.post("/login", authctl.UserLogin);

module.exports = router;
