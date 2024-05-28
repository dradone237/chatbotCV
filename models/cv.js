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
    data: {
      type: DataTypes.BLOB('long'),
      allowNull: false,
    },
    date_creation: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    
  });
  return cv;
};
