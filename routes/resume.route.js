const express = require("express");

let router = express.Router();
const resumeCtlr = require("../controllers/resume.controller");

router.put("", resumeCtlr.createResume);

module.exports = router;
