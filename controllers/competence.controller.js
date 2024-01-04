const bcrypt = require("bcrypt");
const db = require("../config/dbconfig");
const Competence = db.Competence;
//**creation des utilisateurs */

exports.createCompetence = async (req, res) => {
  const { pourcentage, nom_competence } = req.body;
  if (!nom_competence || !pourcentage) {
    return res
      .status(400)
      .json({ message: "rassuré vous d'avoir remplir tous les champs" });
  }
  try {
    //**enregistrement  */
    let competence = await Competence.create(req.body);

    return res.json({ message: "utilisateur crée", data: competence });
  } catch (error) {
    if (error.name === "SequelizeDatabaseError") {
      return res.status(500).json({ message: "database error" });
    }
    return res.status(500).json({ message: "Hash error" });
  }
};
