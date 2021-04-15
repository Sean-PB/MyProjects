package com.example.tutorial2;

import android.os.Bundle;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

public class SecondActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);

        if (getIntent().hasExtra("AndroidStudioProjects.Tutorial2.SOMETHING"))
        {
            TextView textView = (TextView) findViewById(R.id.textView);
            String text = getIntent().getExtras().getString("AndroidStudioProjects.Tutorial2.SOMETHING");

            textView.setText(text);
        }

    }
}
