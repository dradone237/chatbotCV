const {DataTypes} = require("sequelize")

module.exports =  (sequelize) => {
  const cv = sequelize.define("cvs", {
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
    url_telechargement: {
      type: DataTypes.TEXT,
      allowNull: false,
    },
    url_visualisation: {
      type: DataTypes.JSON(255),
      allowNull: false,
    },
    date_creation: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    
  });
  return cv;
};
