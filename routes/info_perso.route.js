const express = require("express");

let router = express.Router();
const info_persoCtlr = require("../controllers/info_perso.controller");
router.put("", info_persoCtlr.upload, info_persoCtlr.createUser);

module.exports = router;
