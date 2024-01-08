const express = require("express");

let router = express.Router();
const usersCtlr = require("../controllers/users.controller");

router.put("", usersCtlr.UserInscription);
router.get("/:telephone", usersCtlr.getUser);

module.exports = router;
