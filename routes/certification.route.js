const express = require("express");

let router = express.Router();
const certificationCtlr = require("../controllers/certification.controller");

router.put("", certificationCtlr.createCertification);

module.exports = router;
