const express = require("express");

let router = express.Router();
const usersCtlr = require("../controllers/users.controller");

router.put("", usersCtlr.UserInscription);

module.exports = router;
