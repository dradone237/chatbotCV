const bcrypt = require("bcrypt");
const db = require("../config/dbconfig");
const Education = db.Education;
//**creation des utilisateurs */

exports.createEducation = async (req, res) => {
  const { nom_ecole, diplome, date_debut, date_fin } = req.body;
  if (!nom_ecole || !diplome || !date_debut || !date_fin) {
    return res
      .status(400)
      .json({ message: "rassuré vous d'avoir remplir tous les champs" });
  }
  try {
    //**enregistrement  */
    let edu = await Education.create(req.body);

    return res.json({ message: "utilisateur crée", data: edu });
  } catch (error) {
    if (error.name === "SequelizeDatabaseError") {
      return res.status(500).json({ message: "database error" });
    }
    return res.status(500).json({ message: "Hash error" });
  }
};
