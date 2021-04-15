package finalProject;

import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.ArrayList;

public class Unit<T> extends AbstractUnit
{	
	private static int num;
	
	// ArrayList variable
	private ArrayList<T> container = null;
	
	// Constructor
	public Unit()
	{
		container = new ArrayList<T>();
		createStatsFile();
	}
	
	@Override
	public void createStatsFile() 
	{
		// Creating warrior models for file input
		Warrior grandma = new Warrior("Grandma",1,10,60);
		Warrior lion = new Warrior("Lion", 6, 40, 75);
		Warrior rick = new Warrior("Rick", 2, 100, 90);
		Warrior morty = new Warrior("Morty", 4, 25, 70);
		Warrior spartan = new Warrior("Spartan", 5, 35, 80);
		Warrior zombie = new Warrior("Zombie", 3, 25, 100);
		
		// Text file
		try
		{
			PrintWriter outputStream = new PrintWriter("WarriorStats.txt");
			
			// Writing to text file
			outputStream.println("Name, speed, attack, health\n");
			outputStream.println(grandma + "\n");
			outputStream.println(lion + "\n");
			outputStream.println(rick + "\n");
			outputStream.println(morty + "\n");
			outputStream.println(spartan + "\n");
			outputStream.println(zombie + "\n");
			
			outputStream.close();
		}
		catch(FileNotFoundException e)
		{
			System.out.println(e);
		}
		
	}
	
	// ArrayList methods
	public boolean add(T object)
	{
		container.add(object);
		
		return true;
	}
	
	public boolean remove(T object)
	{
		container.remove(object);
		
		return true;
	}
	
	public void clear()
	{
		container.clear();
	}

	public T get(int i)
	{
		return this.container.get(i);
	}
	
	public int size()
	{
		return container.size();
	}
	
	public boolean isEmpty()
	{
		return container.isEmpty();
	}
	
	@Override
	public String toString()
	{
		int num = container.size();
		String sNum = Integer.toString(num);
		
		String string = "";
		
		for(int i = 0; i < 1; i++)
		{
			string += sNum + " " + this.container.get(i);
		}
		
		return string;
	}
}
