package com.example.moviecatalog;

import android.content.Intent;
import android.media.Image;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.RatingBar;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

public class AddWatchlistItemActivity extends AppCompatActivity {
    String FILE_NAME = "watchist.txt";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.add_watchlist_item);

        ImageButton cancelButton = (ImageButton)findViewById(R.id.cancelButton);
        ImageButton doneButton = (ImageButton)findViewById(R.id.doneButton);

        // Cancel button
        cancelButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent startIntent = new Intent(getApplicationContext(), WatchlistActivity.class);

                startActivity(startIntent);
            }
        });

        // Done button
        doneButton.setOnClickListener(new View.OnClickListener() {
            EditText titleEditText = (EditText) findViewById(R.id.titleEditText);
            EditText genreEditText = (EditText) findViewById(R.id.genreEditText);
            EditText releaseDate = (EditText) findViewById(R.id.releaseDateEditText);
            CheckBox notification = (CheckBox) findViewById(R.id.notifyMeButton);
            EditText descriptionEditText = (EditText) findViewById(R.id.descriptionEditText);

            @Override
            public void onClick(View v) {
                // If title field is not filled out
                if ((titleEditText.getText().toString().trim().equals(""))) {
                    Toast toast = Toast.makeText(AddWatchlistItemActivity.this,
                            "Title Required", Toast.LENGTH_LONG);
                    toast.show();
                }
                else {
                    // Gets movie data
                    String title = titleEditText.getText().toString();
                    String genre = genreEditText.getText().toString();
                    String date = releaseDate.getText().toString();
                    String description = descriptionEditText.getText().toString();
                    float notify = Float.parseFloat("0");
                    if (notification.isChecked()) {
                        notify = Float.parseFloat("1");
                    }

                    // Accounting for non filled out fields
                    if (genre.equals("")) genre = "*";
                    if (description.equals("")) description = "*";
                    if (date.equals("")) date = "*";

                    // Creates movie
                    Movie movie = new Movie(title, genre, date, description, notify);

                    // Write movie to file
                    FileOutputStream fileOutputStream = null;
                    try {
                        fileOutputStream = openFileOutput(FILE_NAME, MODE_APPEND);
                        fileOutputStream.write(movie.toString().getBytes());
                    } catch (FileNotFoundException e) {
                        e.printStackTrace();
                    } catch (IOException e) {
                        e.printStackTrace();
                    } finally {
                        try {
                            fileOutputStream.close();
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }

                    // Display toast
                    Toast.makeText(AddWatchlistItemActivity.this, "Movie Saved to Watchlist",
                            Toast.LENGTH_LONG).show();

                    // Change activity
                    Intent startIntent = new Intent(getApplicationContext(), WatchlistActivity.class);
                    startActivity(startIntent);
                }
            }
        });
    }
}
