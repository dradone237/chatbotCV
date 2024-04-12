const db = require("../config/dbconfig")
const Resume = db.Resume;
//** enregistrement d'un resume */

exports.createResume = async (req, res)=> {
  const { resume } = req.body;
  if (!resume) {
    return res
      .status(400)
      .json({ message: "rassuré vous d'avoir remplir tous les champs" });
  }
  try {
    //**enregistrement  */
    let resumes = await Resume.create({...req.body,userId:req.id});

    return res.status(200).json({ message: "resume OK", data: resumes });
  } catch (error) {
    if (error.name === "SequelizeDatabaseError") {
      return res.status(500).json({ message: "database error" , error:error.name});
    }
    return res.status(500).json({message: "database error" , message: error.name });
  }
}
