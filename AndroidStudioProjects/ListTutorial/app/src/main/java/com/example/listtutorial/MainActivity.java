package com.example.listtutorial;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.content.res.Resources;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;

public class MainActivity extends AppCompatActivity {

    ListView myListView;
    String[] items;
    String[] genres;
    String[] dates;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Resources res = getResources();
        myListView = (ListView) findViewById(R.id.myListView);
        items = res.getStringArray(R.array.items);
        genres = res.getStringArray(R.array.genres);
        dates = res.getStringArray(R.array.dates);

        itemAdapter itemAdapter = new itemAdapter(this, items,  genres, dates);
        myListView.setAdapter(itemAdapter);

        // Makes each list item clickable to see the picture
        myListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                Intent showDetailActivity = new Intent(getApplicationContext(), detailActivity.class);
                showDetailActivity.putExtra("com.example.listtutorial.ITEM_INDEX", position);
                startActivity(showDetailActivity);
            }
        });
    }
}
