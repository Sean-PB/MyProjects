package com.example.tutorial2;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Button secondActivityButton = (Button) findViewById(R.id.secondActivityButton);
        Button googleButton = (Button) findViewById(R.id.googleButton);

        // Launches activity within our own app
        secondActivityButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent startIntent = new Intent(getApplicationContext(), SecondActivity.class);
                // Show how to pass information to second screen / activity
                startIntent.putExtra("AndroidStudioProjects.Tutorial2.SOMETHING", "Hi Sean!");

                startActivity(startIntent);
            }
        });

        // Launches activity outside our own app
        googleButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String google = "http://www.google.com";
                Uri webaddress = Uri.parse(google);

                Intent goToGoogle = new Intent(Intent.ACTION_VIEW, webaddress);
                if (goToGoogle.resolveActivity(getPackageManager()) != null)
                {
                    startActivity(goToGoogle);
                }
            }
        });
    }
}
