package com.example.listtutorial;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

public class itemAdapter extends BaseAdapter {

    LayoutInflater mInflater;
    String[] items;
    String[] genres;
    String[] dates;

    public itemAdapter(Context c, String[] i, String[] g, String[] d) {
        items = i;
        genres = g;
        dates = d;
        mInflater = (LayoutInflater) c.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
    }

    @Override
    public int getCount() {
        return items.length;
    }

    @Override
    public Object getItem(int position) {
        return items[position];
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {

        View v = mInflater.inflate(R.layout.my_listview_detail, null);
        TextView nameTextView = (TextView) v.findViewById(R.id.nameTextView);
        TextView genreTextView = (TextView) v.findViewById(R.id.genreTextView);
        TextView dateTextView = (TextView) v.findViewById(R.id.dateTextView);

        String name = items[position];
        String genre = genres[position];
        String date = dates[position];

        nameTextView.setText(name);
        genreTextView.setText(genre);
        dateTextView.setText(date);

        return v;
    }
}
