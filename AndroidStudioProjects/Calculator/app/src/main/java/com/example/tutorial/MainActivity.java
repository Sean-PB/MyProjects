package com.example.tutorial;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import org.w3c.dom.Text;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // Assigning buttons
        Button addButton = (Button) findViewById(R.id.addButton);
        Button subButton = (Button) findViewById(R.id.subButton);
        Button multiplyButton = (Button) findViewById(R.id.multiplyButton);
        Button divideButton = (Button) findViewById(R.id.divideButton);
        Button memAddButton = (Button) findViewById(R.id.memAddButton);
        Button memSubButton = (Button) findViewById(R.id.memSubButton);
        Button clearButton = (Button) findViewById(R.id.clearButton);
        Button clearMemButton = (Button) findViewById(R.id.clearMemButton);
        Button signButton = (Button) findViewById(R.id.signButton);


        // Add button functionality
        addButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                EditText firstNumEditText = (EditText) findViewById(R.id.firstNumEditText);
                TextView resultTextView = (TextView) findViewById(R.id.resultTextView);

                double num1 = Double.parseDouble(firstNumEditText.getText().toString());
                double num2 = Double.parseDouble(resultTextView.getText().toString());
                double result = num1 + num2;
                resultTextView.setText(result +"");
                firstNumEditText.setText(null);
            }
        });

        // Sub button functionality
        subButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                EditText firstNumEditText = (EditText) findViewById(R.id.firstNumEditText);
                TextView resultTextView = (TextView) findViewById(R.id.resultTextView);

                double num1 = Double.parseDouble(resultTextView.getText().toString());
                double num2 = Double.parseDouble(firstNumEditText.getText().toString());
                double result = num1 - num2;
                resultTextView.setText(result +"");
                firstNumEditText.setText(null);
            }
        });

        // Multiply button functionality
        multiplyButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                EditText firstNumEditText = (EditText) findViewById(R.id.firstNumEditText);
                TextView resultTextView = (TextView) findViewById(R.id.resultTextView);

                double num1 = Double.parseDouble(firstNumEditText.getText().toString());
                double num2 = Double.parseDouble(resultTextView.getText().toString());
                double result = num1 * num2;
                resultTextView.setText(result +"");
                firstNumEditText.setText(null);
            }
        });

        // Divide button functionality
        divideButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                EditText firstNumEditText = (EditText) findViewById(R.id.firstNumEditText);
                TextView resultTextView = (TextView) findViewById(R.id.resultTextView);

                double num1 = Double.parseDouble(resultTextView.getText().toString());
                double num2 = Double.parseDouble(firstNumEditText.getText().toString());
                double result = num1 / num2;
                resultTextView.setText(result +"");
                firstNumEditText.setText(null);
            }
        });

        // memAdd button functionality
        memAddButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                TextView resultTextView = (TextView) findViewById(R.id.resultTextView);
                TextView memTextView = (TextView) findViewById(R.id.memTextView);

                double num1 = Double.parseDouble(resultTextView.getText().toString());
                double num2 = Double.parseDouble(memTextView.getText().toString());
                double result = num1 + num2;
                memTextView.setText(result +"");
            }
        });

        // memSub button functionality
        memSubButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                TextView resultTextView = (TextView) findViewById(R.id.resultTextView);
                TextView memTextView = (TextView) findViewById(R.id.memTextView);

                double num1 = Double.parseDouble(memTextView.getText().toString());
                double num2 = Double.parseDouble(resultTextView.getText().toString());
                double result = num1 - num2;
                memTextView.setText(result +"");
            }
        });

        // memClear button functionality
        clearMemButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                TextView memTextView = (TextView) findViewById(R.id.memTextView);

                memTextView.setText(0 + "");
            }
        });

        // Clear button functionality
        clearButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                TextView resultTextView = (TextView) findViewById(R.id.resultTextView);
                EditText firstNumEditText = (EditText) findViewById(R.id.firstNumEditText);

                resultTextView.setText(0 + "");
                firstNumEditText.setText(null);
            }
        });

        // Sign button functionality
        signButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                EditText firstNumEditText = (EditText) findViewById(R.id.firstNumEditText);

                double num = Double.parseDouble(firstNumEditText.getText().toString());

                num = num * -1;

                firstNumEditText.setText(num + "");
            }
        });

    }
}
