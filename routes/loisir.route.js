const Router =require("express")
let router = Router();
const loisirCtlr = require("../controllers/loisir.controller")

router.put("", loisirCtlr.createLoisir);

module.exports = router;
