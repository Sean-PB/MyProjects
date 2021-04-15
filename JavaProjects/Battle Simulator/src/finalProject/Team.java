package finalProject;

import java.util.ArrayList;

public class Team<T> 
{
	// ArrayList variable
	private ArrayList<T> container = null;
	
	// Constructor
	public Team()
	{
		container = new ArrayList<T>();
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
	
	public int size()
	{
		return container.size();
	}
	
	public void clear()
	{
		container.clear();
	}
	
	public T get(int i)
	{
		return this.container.get(i);
	}
	
	@Override
	public String toString()
	{
		String string = "";
		
		for(int i = 0; i < container.size(); i++)
		{
			string += this.container.get(i);
		}
		
		return string;
	}
	
	
}