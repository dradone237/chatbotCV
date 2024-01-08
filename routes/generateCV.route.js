const express = require("express");

let router = express.Router();
const generateCtlr = require("../controllers/generateCv.controller");

router.post("", generateCtlr.generateCvPdf);

module.exports = router;
