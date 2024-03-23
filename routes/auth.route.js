const Router =require("express")
let router = Router();
 const logCtlr = require("../controllers/auth.controller")
router.post("/login", logCtlr.UserLogin);

module.exports = router;
