package com.example.moviecatalog;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.RatingBar;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;


public class AddMovieActivity extends AppCompatActivity {
    String FILE_NAME = "seenList.txt";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.add_item_layout);

        // Assigning buttons
        ImageButton cancelButton = (ImageButton)findViewById(R.id.cancelButton);
        ImageButton doneButton = (ImageButton) findViewById(R.id.doneButton);

        // Cancel button
        cancelButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent startIntent = new Intent(getApplicationContext(), MainActivity.class);

                startActivity(startIntent);
            }
        });

        // Done button
        doneButton.setOnClickListener(new View.OnClickListener() {
            EditText titleEditText = (EditText) findViewById(R.id.titleEditText);
            EditText genreEditText = (EditText) findViewById(R.id.genreEditText);
            EditText releaseDate = (EditText) findViewById(R.id.releaseDateEditText);
            RatingBar ratingBar = (RatingBar) findViewById(R.id.ratingBar);
            EditText descriptionEditText = (EditText) findViewById(R.id.descriptionEditText);

            @Override
            public void onClick(View v) {
                // If title field is not filled out
                if ((titleEditText.getText().toString().trim().equals(""))) {
                    Toast toast = Toast.makeText(AddMovieActivity.this,
                            "Title Required", Toast.LENGTH_LONG);
                    toast.show();
                }
                else {
                    // Gets movie data
                    String title = titleEditText.getText().toString();
                    String genre = genreEditText.getText().toString();
                    String date = releaseDate.getText().toString();
                    String description = descriptionEditText.getText().toString();
                    float rating = ratingBar.getRating();

                    // Accounting for non filled out fields
                    if (genre.equals("")) genre = "*";
                    if (description.equals("")) description = "*";
                    if (date.equals("")) date = "*";

                    // Create movie object
                    Movie movie = new Movie(title, genre, date, description, rating);

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
                    Toast.makeText(AddMovieActivity.this, "Movie Saved to Seen List",
                            Toast.LENGTH_LONG).show();

                    // Change activity when done
                    Intent startIntent = new Intent(getApplicationContext(), MainActivity.class);
                    startActivity(startIntent);
                }
            }
        });
    }
}
