package com.example.moviecatalog;

public class Movie {
    private String title, genre, description, date;
    private float rating;

    public Movie(String title, String genre, String date, String description, float rating) {
        this.title = title;
        this.genre = genre;
        this.description = description;
        this.date = date;
        this.rating = rating;
    }

    // Getters
    public String getTitle() {
        return title;
    }
    public String getGenre() {
        return genre;
    }
    public String getDescription() {
        return description;
    }
    public String getDate() {
        return date;
    }
    public float getRating() {
        return rating;
    }

    // Setters
    public void setTitle(String title) {
        this.title = title;
    }
    public void setGenre(String genre) {
        this.genre = genre;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public void setDate(String date) {
        this.date = date;
    }
    public void setRating(float rating) {
        this.rating = rating;
    }

    // toString
    public String toString() {
        return title + ", " + genre + ", " + date + ", " + description + ", " + rating + "\n";
    }
}
