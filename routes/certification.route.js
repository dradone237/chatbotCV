const Router =require("express")
let router = Router();
const certiCtlr = require("../controllers/certification.controller")
router.put("", certiCtlr.createCertification);

module.exports = router;
