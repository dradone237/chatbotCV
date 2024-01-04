const express = require("express");

let router = express.Router();
const eduCtlr = require("../controllers/education.controller");

router.put("", eduCtlr.createEducation);

module.exports = router;
