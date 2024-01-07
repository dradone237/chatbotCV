const bcrypt = require("bcrypt");
const db = require("../config/dbconfig");
const Users = db.Users;
//**creation des utilisateurs */

exports.UserInscription = async (req, res) => {
  const { telephone, password } = req.body;
  if (!telephone || !password) {
    return res
      .status(400)
      .json({ message: "rassuré vous d'avoir remplir tous les champs" });
  }
  try {
    //**recuperation d'un utilisateur */
    let user = await Users.findOne({ where: { telephone: telephone } });

    if (user != null) {
      return res.status(409).json({
        message: "le numero de telephone existe deja changer s'il vous plait",
      });
    }
    //**harchage du mot de passe */
    let hash = await bcrypt.hash(password, 10);
    req.body.password = hash;

    //**creation de l'utilisateur */
    let inscrit = await Users.create(req.body);

    return res.json({ message: "utilisateur crée", data: inscrit });
  } catch (error) {
    if (error.name === "SequelizeDatabaseError") {
      return res.status(500).json({ message: "database error" });
    }
    return res.status(500).json({ message: "Hash error" });
  }
};
