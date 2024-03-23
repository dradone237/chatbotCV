const Router =require("express")
let router = Router();
const cvCtlr = require("../controllers/generateCv.controller")

router.post("", cvCtlr.generateCvPdf);

module.exports = router;
