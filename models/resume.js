const { DataTypes } = require("sequelize");

module.exports = (sequelize) => {
  const Resume = sequelize.define("resume", {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },
    resume: {
      type: DataTypes.TEXT,
      allowNull: false,
    },
  });
  return Resume;
};
