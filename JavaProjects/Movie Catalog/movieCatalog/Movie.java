package movieCatalog;

public class Movie {
	
	String name;
	String genre;
	int rating;
	
	public Movie(String name, String genre, int rating)
	{
		this.name = name;
		this.genre = genre;
		this.rating = rating;
	}
	
	public String getName()
	{
		return name;
	}
	public String getGenre()
	{
		return genre;
	}
	public int getRating()
	{
		return rating;
	}
	
	private void setName(String name)
	{
		this.name = name;
	}
	private void setGenre(String genre)
	{
		this.genre = genre;
	}
	private void setRating(int rating)
	{
		this.rating = rating;
	}
	
	
	
	
	
}
