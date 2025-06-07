import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

const db = admin.firestore();
const messaging = admin.messaging();

export const notifyTempleOnBookingCreate = functions.firestore
  .document("bookings/{bookingId}")
  .onCreate(async (snap) => {
    const booking = snap.data();
    const templeId = booking?.templeId;
    const amount = booking?.price ?? 0;

    if (!templeId) {
      console.warn("templeId missing in booking");
      return;
    }

    const templeRef = db.collection("temples").doc(templeId);
    const templeDoc = await templeRef.get();

    if (!templeDoc.exists) {
      console.warn("Temple doc not found:", templeId);
      return;
    }

    const fcmTokens: string[] = templeDoc.data()?.fcmTokens ?? [];
    if (!Array.isArray(fcmTokens) || fcmTokens.length === 0) {
      console.warn("No FCM tokens for temple:", templeId);
      return;
    }

    const title = "New Booking Received";
    const body = `A new booking for ₹${amount} received. Please verify the payment.`;

    // Store the notification
    const notifRef = templeRef.collection("notifications").doc();
    const notifData = {
      title,
      body,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      type: "booking",
      bookingId: snap.id,
      isRead: false,
    };
    await notifRef.set(notifData);

    const message: admin.messaging.MulticastMessage = {
      tokens: fcmTokens,
      notification: { title, body },
      data: {
        type: "booking",
        bookingId: snap.id,
        notificationId: notifRef.id,
      },
    };

    try {
      const response = await messaging.sendEachForMulticast(message);

      const invalidTokens: string[] = [];

      response.responses.forEach((resp, idx) => {
        if (!resp.success) {
          const error = resp.error;
          if (error?.code === 'messaging/registration-token-not-registered') {
            invalidTokens.push(fcmTokens[idx]);
          }
        }
      });

      if (invalidTokens.length > 0) {
        await templeRef.update({
          fcmTokens: admin.firestore.FieldValue.arrayRemove(...invalidTokens),
        });
        console.warn("Removed invalid FCM tokens:", invalidTokens);
      }

      if (response.successCount > 0) {
        console.log("Notification sent to temple:", templeId);
      } else {
        console.warn("All notifications failed for temple:", templeId);
      }
    } catch (err) {
      console.error("Failed to send notification:", err);
    }
  });
