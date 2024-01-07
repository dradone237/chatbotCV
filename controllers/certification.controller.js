const db = require("../config/dbconfig");
const Certification = db.Certification;

//**enregistrement d'une experience */

exports.createCertification = async (req, res) => {
  const { intitule, centre_formation, date } = req.body;
  if (!intitule || !centre_formation || !date) {
    return res
      .status(400)
      .json({ message: "rassuré vous d'avoir remplir tous les champs" });
  }
  console.log(intitule);
  console.log(centre_formation);
  console.log(date);
  try {
    //**enregistrement  */
    let certification = await Certification.create(req.body);

    return res.json({ message: "utilisateur crée", data: certification });
  } catch (error) {
    if (error.name === "SequelizeDatabaseError") {
      return res.status(500).json({ message: "database error" });
    }
    return res.status(500).json({ message: error.name });
  }
};
