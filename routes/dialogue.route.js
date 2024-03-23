const Router =require("express")
let router = Router();
const dialoCtlr = require("../controllers/dialogue.controller")

router.post("", dialoCtlr.createDialogue);
router.get("/:userId",dialoCtlr.getDialogue);

module.exports = router;
