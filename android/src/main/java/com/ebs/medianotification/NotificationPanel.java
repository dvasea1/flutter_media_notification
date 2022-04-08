package com.ebs.medianotification;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.widget.RemoteViews;
import android.view.KeyEvent;
import android.graphics.Color;
import androidx.core.app.NotificationCompat;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
/**
 * Created by dmitry on 14.08.18.
 */

public class NotificationPanel {
    private Context parent;
    private NotificationManager nManager;
    private NotificationCompat.Builder nBuilder;
  //  private RemoteViews remoteView;
    private String title;
    private String author;
    private boolean play;

    public NotificationPanel(Context parent, String title, String author, boolean play) {
        this.parent = parent;
        this.title = title;
        this.author = author;
        this.play = play;

        showNotif();
    }

    void showNotif(){
        int smallIcon = parent.getResources().getIdentifier(
                "ic_notification_icon", "drawable", parent.getPackageName());
        Bitmap icon = BitmapFactory.decodeResource(parent.getResources(), smallIcon);
        nBuilder = new NotificationCompat.Builder(parent, "medianotification")
                .setContentTitle(this.title)
                .setContentText(this.author)
                .setLargeIcon(icon)
                .setSmallIcon(smallIcon)

                .setVisibility(NotificationCompat.VISIBILITY_PUBLIC)
                .setOngoing(true)
                .setOnlyAlertOnce(true)
                .setVibrate(new long[]{0L})
                .setStyle(new androidx.media.app.NotificationCompat.MediaStyle().setShowActionsInCompactView(0))
                .setSound(null);

        Intent intent = new Intent(parent, NotificationReturnSlot.class)
                .setAction("toggle")
                .putExtra("title", this.title)
                .putExtra("author", this.author)
                .putExtra("action", !this.play ? "play" : "pause");
        PendingIntent pendingIntent;


        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            pendingIntent = = PendingIntent.getBroadcast(parent, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE);



        }else {
            pendingIntent = = PendingIntent.getBroadcast(parent, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT);

        }



        if (this.play) {
            nBuilder.addAction(R.drawable.baseline_pause_black_48, "Pause",
                    pendingIntent);
        } else {
            nBuilder.addAction(R.drawable.baseline_play_arrow_black_48, "Play",
                    pendingIntent);
        }

        Notification notification = nBuilder.build();


        nManager = (NotificationManager) parent.getSystemService(Context.NOTIFICATION_SERVICE);
        nManager.notify(1, notification);
    }


    public void setPlay(boolean play) {
        this.play = play;
        showNotif();
    }

    public void notificationCancel() {
        nManager.cancel(1);
    }
}

