const Router =require("express")
let router = Router();
const projetCtlr = require("../controllers/projet.controller")
router.put("", projetCtlr.createProjet);

module.exports = router;
