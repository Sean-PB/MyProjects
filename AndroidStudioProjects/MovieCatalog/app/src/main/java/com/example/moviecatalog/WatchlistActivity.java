package com.example.moviecatalog;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class WatchlistActivity extends AppCompatActivity {

    static List<Movie> wl = new ArrayList<Movie>();
    RecyclerView watchListRecyclerView;
    String FILE_NAME = "watchist.txt";


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.watchlist);

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
            wl.clear();
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
                Float notify = Float.parseFloat(saved.substring(0, saved.indexOf("\n")));
                saved = saved.substring(saved.indexOf("\n") + 1);

                if (genre.equals("*")) genre = "Genre";
                if (date.equals("*")) date = "Release Date";
                if (description.equals("*")) description = "";

                // Takes movie data and makes it into a Movie object, then adds to array list
                Movie movie = new Movie(title, genre, date, description, notify);
                wl.add(movie);
            }

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Lists
        watchListRecyclerView = findViewById(R.id.watchistRecyclerView);

        MyAdapter myAdapter = new MyAdapter(this, wl);
        watchListRecyclerView.setAdapter(myAdapter);
        watchListRecyclerView.setLayoutManager(new LinearLayoutManager(this));

        // Assigning Buttons
        Button changeListButton2 = (Button) findViewById(R.id.changeListButton2);
        ImageButton addButton2 = (ImageButton) findViewById(R.id.addButton2);
        ImageButton filterButton2 = (ImageButton) findViewById(R.id.filterButton2);

        // Change List Button Functionality
        // Changes activity to WatchlistActivity
        changeListButton2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent startIntent = new Intent(getApplicationContext(), MainActivity.class);

                startActivity(startIntent);
            }
        });

        // Edit list button functionality
        addButton2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent startIntent = new Intent(getApplicationContext(), AddWatchlistItemActivity.class);

                startActivity(startIntent);
            }
        });
    }
}
