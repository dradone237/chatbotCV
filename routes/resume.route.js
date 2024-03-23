const Router =require("express")
let router = Router();

const resumeCtlr = require("../controllers/resume.controller")
router.put("", resumeCtlr.createResume);

module.exports = router;
