package finalProject;

import java.util.InputMismatchException;
import java.util.Scanner;
import java.io.FileInputStream;
import java.io.FileNotFoundException;

public class Warrior{
	
	// Instance variables
	private String name;
	private int speed;
	private int attack;
	private int health;
	
	// Full constructor (for writting to the WarriorStats file)
	public Warrior(String name, int speed, int attack, int health)
	{
		setName(name);
		setSpeed(speed);
		setAttack(attack);
		setHealth(health);
	}
	
	// File constructor
	public Warrior(String warriorName)
	{
		Scanner file = null;
		
		try
		{
			file = new Scanner(new FileInputStream("WarriorStats.txt"));
			file.useDelimiter(", |\\n|s: Stats = ");
			
			// Skip the header
			file.nextLine();
			
			while(file.hasNextLine())
			{
				// Find the correct name
				String nameTest = file.next();
				if(warriorName.contentEquals(nameTest))
				{
					int wSpeed = file.nextInt();
					int wAttack = file.nextInt();
					int wHealth = file.nextInt();

					setName(nameTest);
					setSpeed(wSpeed);
					setAttack(wAttack);
					setHealth(wHealth);
				}
				else 
				{
					file.nextLine();
				}
				
				
			}
		}
		catch(FileNotFoundException e)
		{
			System.out.println(e);
		}
		catch(InputMismatchException e)
		{
			System.out.println("Idk whats wrong bro");
		}
		
	}
	
	// Getters
	public String getName()
	{
		return name;
	}
	public int getSpeed()
	{
		return speed;
	}
	public int getAttack()
	{
		return attack;
	}
	public int getHealth()
	{
		return health;
	}
	
	// Setters
	public void setName(String name)
	{
		this.name = name;
	}
	public void setSpeed(int speed)
	{
		this.speed = speed;
	}
	public void setAttack(int attack)
	{
		this.attack = attack;
	}
	public void setHealth(int health)
	{
		this.health = health;
	}
	
	@Override
	// toString
	public String toString()
	{
		return name + "s: Stats = " + speed + ", " + attack + ", " + health + ", " + "\n";
	}
	
	
}