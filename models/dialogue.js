const { DataTypes } = require("sequelize");

module.exports = (sequelize) => {
  const Diologue = sequelize.define("dialogue", {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },
    userId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      
    },
    question: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    reponse: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    date_reponse: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    date_question:{
        type: DataTypes.DATE,
        allowNull: false,
        
    },

    links: {
      type: DataTypes.STRING,
      allowNull: false,
    },
  });
  return Diologue;
};
