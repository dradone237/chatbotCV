
const _hash = require("bcrypt")

const db = require("../config/dbconfig")
// const experience = require("../models/experience");
// const info_perso = require("../models/info_perso");
// const langue = require("../models/langue");
// const loisir = require("../models/loisir");
// const projet = require("../models/projet");
const Users = db.Users;
//**creation des utilisateurs */

exports.UserInscription = async  (req, res) =>{
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
    let hash = await _hash(password, 10);
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
}

//** recuperation d'un utilisateur */
exports.getUser = async (req, res)=> {
  const user_telephone = req.params.telephone;
  if (!user_telephone) {
    return res.status(400).json({ message: "l'identifiant est requis" });
  }
  console.log(user_telephone);
  try {
    let user = await Users.findOne({
      where: { telephone: user_telephone },
      include: [
        db.Certification,
        db.Competence,
        db.Education,
        db.Experience,
        db.Info_perso,
        db.Langue,
        db.Loisir,
        db.Projet,
        db.Resume,
      ],
    });
    if (!user) {
      const message = "l'utilisateur n'existe pas";
      return res.status(404).json({ message });
    }
    return res.json({ message: "voici l'utilisateur", data: user });
  } catch (error) {
    return res
      .status(500)
      .json({ message: "database error", error: error.name });
  }
}
