const express = require("express");

let router = express.Router();
const loisirCtlr = require("../controllers/loisir.controller");

router.put("", loisirCtlr.createLoisir);

module.exports = router;
