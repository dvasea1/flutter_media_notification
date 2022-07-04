package com.ebs.medianotification;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;

public class NotificationReturnSlot extends BroadcastReceiver {

    @Override
    public void onReceive(Context context, Intent intent) {
        switch (intent.getAction()) {
            case "toggle":
                String title = intent.getStringExtra("title");
                String author = intent.getStringExtra("author");
                String action = intent.getStringExtra("action");

                try{
                    MediaNotificationPlugin.show(title, author, action.equals("play"));
                   // System.out.println(" action "+action);
                    MediaNotificationPlugin.callEvent(action);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                break;
        }
    }
}

