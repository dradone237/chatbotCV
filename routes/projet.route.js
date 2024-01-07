const express = require("express");

let router = express.Router();
const projetCtlr = require("../controllers/projet.controller");

router.put("", projetCtlr.createProjet);

module.exports = router;
