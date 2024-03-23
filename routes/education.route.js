const Router =require("express")
let router = Router();
const eduCtlr = require("../controllers/education.controller")
router.put("", eduCtlr.createEducation);

module.exports = router;
