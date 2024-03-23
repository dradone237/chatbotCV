const Router =require("express")
let router = Router();
const compCtlr = require("../controllers/competence.controller")

router.put("", compCtlr.createCompetence);

module.exports = router;
