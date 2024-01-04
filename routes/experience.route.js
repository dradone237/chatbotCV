const express = require("express");

let router = express.Router();
const experienceCtlr = require("../controllers/experience.controller");
router.put("", experienceCtlr.createExperience);

module.exports = router;
