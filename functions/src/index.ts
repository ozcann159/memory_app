// cloud-functions/functions/src/index.ts

import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import * as nodemailer from 'nodemailer';

admin.initializeApp();

exports.sendRejectionEmail = functions.firestore
  .document('memories/{memoryId}')
  .onUpdate(async (change, context) => {
    const newValue = change.after.data();
    const previousValue = change.before.data();

    // Sadece onay durumu değiştiyse ve hatıra reddedildiyse işlem yap
    if (newValue.isApproved === false && previousValue.isApproved === true) {
      const userEmail = newValue.email;

      const transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
          user: 'your-email@gmail.com', // Gönderim için Gmail hesabı
          pass: 'your-password' // Gmail hesabı şifresi
        }
      });

      const mailOptions = {
        from: 'your-email@gmail.com',
        to: userEmail, // Kullanıcının e-posta adresi
        subject: 'Hatıranız Reddedildi',
        text: `Merhaba,\n\nHatıranız admin tarafından reddedildi. Detaylar için uygulamayı kontrol edebilirsiniz.\n\nEğer bu hatırayı yeniden göndermek isterseniz, lütfen uygulamaya giriş yapın ve düzenleyin.\n\nSaygılarımızla,\nUygulama Ekibi`
      };

      try {
        await transporter.sendMail(mailOptions);
        console.log(`E-posta başarıyla gönderildi: ${userEmail}`);
      } catch (error) {
        console.error('E-posta gönderilirken hata oluştu:', error);
      }
    }
  });
