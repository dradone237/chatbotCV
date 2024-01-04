const express = require("express");

let router = express.Router();
const inscriptionCtlr = require("../controllers/inscription.controller");

router.put("", inscriptionCtlr.UserInscription);

module.exports = router;
