const express = require("express");

let router = express.Router();
const competenceCtlr = require("../controllers/competence.controller");

router.put("", competenceCtlr.createCompetence);

module.exports = router;
