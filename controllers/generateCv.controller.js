exports.generateCvPdf = (req, res) => {
  try {
    const PDFDocument = require("pdfkit");
    const fs = require("fs");
    const doc = new PDFDocument();

    doc.pipe(fs.createWriteStream("cv.pdf"));

    //nom et profession
    doc.fontSize(20).text(`Certification`, { align: "center" });
    doc.fontSize(10).text(`Certification`, { align: "center" });

    doc.lineWidth(3);
    doc.moveTo(50, 110).lineTo(550, 110).stroke();
    doc.lineWidth(1);
    doc.moveDown();
    // coordonnees
    doc.fontSize(10).text("adresse / telephone / email", { align: "center" });
    doc.moveDown();
    //profil profestionnel
    doc.fontSize(20).text(`profil profestionnel`);
    doc
      .fontSize(10)
      .text(
        "Modèle traditionnel, ce CV simple professionnel en noir et blanc permet une lecture linéaire et efficace. Les recruteurs sont rassurés par ce format qui ne cache aucune surprise."
      );
    doc.moveDown();
    //competences
    doc.fontSize(20).text(` competences`);
    doc.fontSize(10).text("contenu");
    doc.moveDown();
    //formations
    doc.fontSize(20).text(`formations `);
    doc.fontSize(10).text("contenu");
    doc.moveDown();
    //experience
    doc.fontSize(20).text(` experience`);
    doc.fontSize(10).text("contenu");
    doc.moveDown();
    //projets
    doc.fontSize(20).text(`projets `);
    doc.fontSize(10).text("contenu");
    doc.moveDown();
    //certifications
    doc.fontSize(20).text(`certifications `);
    doc.fontSize(10).text("contenu");
    doc.moveDown();
    //langues
    doc.fontSize(20).text(`langues `);
    doc.fontSize(10).text("contenu");
    doc.moveDown();
    //loisirs
    doc.fontSize(20).text(`loisirs `);
    doc.fontSize(10).text("contenu");
    doc.moveDown();

    doc.end();

    return res.status(200).json({ message: "CV généré avec succès" });
  } catch (error) {
    return res.status(500).json({ error: error.name });
  }
};
