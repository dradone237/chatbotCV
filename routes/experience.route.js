const Router =require("express")
let router = Router();
const expCtlr = require("../controllers/experience.controller")
router.put("", expCtlr.createExperience);
module.exports = router;