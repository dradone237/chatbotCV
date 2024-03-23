const db = require("../config/dbconfig")
const Loisir = db.Loisir;
//**creation des utilisateurs */

exports.createLoisir = async (req, res)=> {
  const { nom_loisir } = req.body;
  if (!nom_loisir) {
    return res
      .status(400)
      .json({ message: "rassuré vous d'avoir remplir tous les champs" });
  }
  try {
    //**enregistrement  */
    let loisir = await Loisir.create({...req.body,userId:req.user.id});

    return res.json({ message: "utilisateur crée", data: loisir });
  } catch (error) {
    if (error.name === "SequelizeDatabaseError") {
      return res.status(500).json({ message: "database error" });
    }
    return res.status(500).json({ message: "Hash error" });
  }
}
