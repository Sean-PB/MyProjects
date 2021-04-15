package com.example.listtutorial;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.media.Image;
import android.os.Bundle;
import android.view.Display;
import android.widget.ImageView;

public class detailActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detail);

        // To decide which image to show
        Intent intent = getIntent();
        int index = intent.getIntExtra("com.example.listtutorial.ITEM_INDEX", -1);

        if (index > -1)
        {
            int pic = getImage(index);
            ImageView img = (ImageView) findViewById(R.id.imageView);
            scaleImg(img, pic);
        }
    }

    // To set the image we want
    private int getImage(int index) {
        switch(index) {
            case 0:
                return R.drawable.star_wars;
            case 1:
                return R.drawable.fight_club;
            case 2:
                return R.drawable.finding_nemo;
            default:
                return -1;
        }
    }

    // Scales the image to fit on phone despite original size of image
    private void scaleImg(ImageView img, int pic) {

        // Gets size of screen
        Display screen = getWindowManager().getDefaultDisplay();
        // Gets instance of bitmap factory class (what we use to scale image)
        BitmapFactory.Options options = new BitmapFactory.Options();

        // Turns on boundaries
        options.inJustDecodeBounds = true;
        // Looks at resource without having to draw it
        BitmapFactory.decodeResource(getResources(), pic, options);

        // Finds the boundries of img and screen
        int imgWidth = options.outWidth;
        int screenWidth = screen.getWidth();

        if (imgWidth > screenWidth)
        {
            int ratio = Math.round((float)imgWidth / (float)screenWidth);
            options.inSampleSize = ratio;
        }
        // Turn off again after using
        options.inJustDecodeBounds = false;

        Bitmap scaledImg = BitmapFactory.decodeResource(getResources(), pic, options);
        img.setImageBitmap(scaledImg);
    }
}
