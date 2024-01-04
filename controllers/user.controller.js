const db = require("../config/dbconfig");
const User = db.User;
const multer = require("multer");

//** 1. create users */

exports.createUser = async (req, res) => {
  const utilisateur = {
    nom: req.body.nom,
    prenom: req.body.prenom,
    profession: req.body.profession,
    sexe: req.body.sexe,
    date_naissance: req.body.date_naissance,
    nationalite: req.body.nationalite,
    email: req.body.email,
    image: req.file ? req.file.path : null,
  };
  console.log(utilisateur.nom);
  console.log(utilisateur.prenom);
  console.log(utilisateur.profession);
  console.log(utilisateur.sexe);
  console.log(utilisateur.date_naissance);
  console.log(utilisateur.nationalite);
  console.log(utilisateur.email);
  console.log(utilisateur.image);
  if (
    !utilisateur.nom ||
    !utilisateur.prenom ||
    !utilisateur.profession ||
    !utilisateur.sexe ||
    !utilisateur.date_naissance ||
    !utilisateur.nationalite ||
    !utilisateur.email
  ) {
    return res
      .status(400)
      .json({ message: "rassuré vous d'avoir remplir tous les champs" });
  }
  try {
    //**recuperation d'un utilisateur */
    let user = await User.findOne({ where: { email: email } });

    if (user != null) {
      return res.status(409).json({
        message: "cette email existe deja changer s'il vous plait",
      });
    }

    //**creation de l'utilisateur */
    let users = await User.create(req.body);

    return res.json({ message: "utilisateur crée", data: users });
  } catch (error) {
    if (error.name === "SequelizeDatabaseError") {
      return res.status(500).json({ message: "database error" });
    }
    return res.status(500).json({ message: "Hash error" });
  }
};

//**2. Upload Image Controller//

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "Images");
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname));
  },
});

exports.upload = multer({
  storage: storage,
  limits: { fileSize: "1000000" },
  fileFilter: (req, file, cb) => {
    const fileTypes = /jpeg|jpg|png|gif/;
    const mimeType = fileTypes.test(file.mimetype);
    const extname = fileTypes.test(path.extname(file.originalname));

    if (mimeType && extname) {
      return cb(null, true);
    }
    cb("Give proper files formate to upload");
  },
}).single("image");
