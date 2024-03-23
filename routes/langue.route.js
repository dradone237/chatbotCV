const Router =require("express")
let router = Router();
const langueCtlr = require("../controllers/langue.controller")
router.put("", langueCtlr.createLangue);

module.exports = router;
