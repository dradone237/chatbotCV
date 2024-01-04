const { DataTypes } = require("sequelize");

module.exports = (sequelize) => {
  const Education = sequelize.define("education", {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },
    nom_ecole: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    diplome: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    date_debut: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    date_fin: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    description: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
  });
  return Education;
};
