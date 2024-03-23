
const Router =require("express")
let router = Router();
const userClt = require("../controllers/users.controller")
router.put("", userClt.UserInscription);
router.get("/:telephone", userClt.getUser);

module.exports = router;
