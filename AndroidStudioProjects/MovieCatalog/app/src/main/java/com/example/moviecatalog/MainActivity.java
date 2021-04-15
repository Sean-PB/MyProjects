package com.example.moviecatalog;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.ObjectInput;
import java.io.ObjectInputStream;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Scanner;

public class MainActivity extends AppCompatActivity {

    static List<Movie> sl = new ArrayList<Movie>();
    RecyclerView seenListRecyclerView;
    String FILE_NAME = "seenList.txt";


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // Read from file
        try {
            // Takes all file contents (bytes) and puts into 1 string
            FileInputStream fileInputStream = openFileInput(FILE_NAME);
            StringBuffer buffer = new StringBuffer();
            int read = -1;
            while ((read = fileInputStream.read()) != -1) {
                buffer.append((char) read);
            }
            String saved = buffer.toString();

            // This will have to be changed later MAYBE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            sl.clear();
            // Clears the array list every time so there aren't duplicates with every new movie !!!

            while(!saved.equals("")) {
            // Takes one line of total string and divides each part into movie data
            String title = saved.substring(0, saved.indexOf(", "));
            saved = saved.substring(saved.indexOf(", ") + 2);
            String genre = saved.substring(0, saved.indexOf(", "));
            saved = saved.substring(saved.indexOf(", ") + 2);
            String date = saved.substring(0, saved.indexOf(", "));
            saved = saved.substring(saved.indexOf(", ") + 2);
            String description = saved.substring(0, saved.indexOf(", "));
            saved = saved.substring(saved.indexOf(", ") + 2);
            Float rating = Float.parseFloat(saved.substring(0, saved.indexOf("\n")));
            saved = saved.substring(saved.indexOf("\n") + 1);

            if (genre.equals("*")) genre = "Genre";
            if (date.equals("*")) date = "Release Date";
            if (description.equals("*")) description = "";

            // Takes movie data and makes it into a Movie object, then adds to array list
            Movie movie = new Movie(title, genre, date, description, rating);
            sl.add(movie);
        }

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Lists
        seenListRecyclerView = findViewById(R.id.seenListRecyclerView);

        MyAdapter myAdapter = new MyAdapter(this, sl);
        seenListRecyclerView.setAdapter(myAdapter);
        seenListRecyclerView.setLayoutManager(new LinearLayoutManager(this));

        // Assigning Buttons
        Button changeListButton = (Button) findViewById(R.id.changeListButton);
        ImageButton addButton = (ImageButton) findViewById(R.id.addButton);
        ImageButton filterButton = (ImageButton) findViewById(R.id.filterButton);

        // Change List Button Functionality
        // Changes activity to WatchlistActivity
        changeListButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent startIntent = new Intent(getApplicationContext(), WatchlistActivity.class);

                startActivity(startIntent);
            }
        });

        // Add list button functionality
        addButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent startIntent = new Intent(getApplicationContext(), AddMovieActivity.class);

                startActivity(startIntent);
            }
        });

    }
}