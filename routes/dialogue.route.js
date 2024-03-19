const express = require("express");

let router = express.Router();
const diolaCtlr = require("../controllers/dialogue.controller");

router.post("", diolaCtlr.createDialogue);
router.get("/:userId",diolaCtlr.getDialogue);

module.exports = router;
