const Router =require("express")
let router = Router();
const persoCtlr = require("../controllers/info_perso.controller")
router.put("", persoCtlr.upload, persoCtlr.createUser);

module.exports = router;
