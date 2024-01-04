const express = require("express");

let router = express.Router();
const langueCtlr = require("../controllers/langue.controller");

router.put("", langueCtlr.createLangue);

module.exports = router;
