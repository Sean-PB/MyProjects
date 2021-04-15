package movieCatalog;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.SwingConstants;

public class Window extends JFrame implements ActionListener{

	ArrayList<Movie> catalog = new ArrayList<Movie>(20);
	
	// Final ints
	private final int WIDTH = 600;
	private final int HEIGHT = 400;
	
	// JTextField
	JTextField nameBox = new JTextField(25);
	JTextField genreBox = new JTextField(15);
	JTextField ratingBox = new JTextField(2);
	
	// Panel
	JPanel panel = new JPanel();
	
	// Window
	public Window()
	{
		super("Movie Catalog");
		setSize(WIDTH, HEIGHT);
		
		add(panel);
		panel.setLayout(new GridLayout(1,2));
		
		//buttons
		panel.add(browse());
		panel.add(addMovie());
	}
	
	// Browse movies 
	public JButton browse()
	{
		JButton browse = new JButton("Browse Movie Catalog");
		browse.addActionListener(this);
		browse.setBackground(new Color(135, 206, 250));
		return browse;
	}
	
	// Add movie
	public JButton addMovie()
	{
		JButton add = new JButton("Add Movie to Catalog");
		add.setBackground(new Color(127, 255, 0));
		add.addActionListener(this);
		return add;
	}
	
	// Browse Movies page
	public void browseMoviesPage()
	{
		// removing main menu buttons
		panel.removeAll();
		panel.revalidate();
		panel.repaint();
		
		// Adding new frame
		panel.setLayout(new BorderLayout());
		
		// Organizing north
		JPanel north = new JPanel();
		panel.add(north, BorderLayout.NORTH);
		north.setLayout(new GridLayout(1,2));
		
		// Back Button
		JButton backButton = new JButton("Back");
		backButton.addActionListener(this);
		north.add(backButton);
		
		// Label
		JLabel addLabel = new JLabel("Movie Catalog", SwingConstants.CENTER);
		north.add(addLabel);
		north.setBackground(new Color(135, 206, 250));
	}
	
	
	// Add movie page
	public void addMoviePage()
	{
		// removing main menu buttons
		panel.removeAll();
		panel.revalidate();
		panel.repaint();
		
		// Adding new frame
		panel.setLayout(new BorderLayout());
		
		// Organizing north
		JPanel north = new JPanel();
		panel.add(north, BorderLayout.NORTH);
		north.setLayout(new GridLayout(1,2));
		
		// Back Button
		JButton backButton = new JButton("Back");
		backButton.addActionListener(this);
		north.add(backButton);
		
		// Label
		JLabel addLabel = new JLabel("Add Movie", SwingConstants.CENTER);
		north.setBackground(new Color(127, 255, 0));
		north.add(addLabel);
		
		// Center ////////////////////////////////////////////////////////////////////////
		JPanel center = new JPanel();
		center.setLayout(new GridLayout(4, 1));
		panel.add(center, BorderLayout.CENTER);
		
		// Labels
		JLabel name = new JLabel("Name:");
		JLabel genre = new JLabel("Genre:");
		JLabel rating = new JLabel("Your Rating:");
		JLabel outOfTen = new JLabel("/   10");
		
		// Text Fields
		JPanel nameBoxPanel = new JPanel();
		JPanel genreBoxPanel = new JPanel();
		JPanel ratingBoxPanel = new JPanel();
		
		nameBoxPanel.add(nameBox);
		genreBoxPanel.add(genreBox);
		ratingBoxPanel.add(ratingBox);
		nameBoxPanel.setBackground(Color.LIGHT_GRAY);
		genreBoxPanel.setBackground(Color.LIGHT_GRAY);
		ratingBoxPanel.setBackground(Color.LIGHT_GRAY);
		
		// Add button
		JButton create = new JButton("ADD");
		create.setBackground(new Color(127, 255, 0));
		create.addActionListener(this);
		
		// Panels
		JPanel first = new JPanel();
		JPanel second = new JPanel();
		JPanel third = new JPanel();
		JPanel fourth = new JPanel();
		
		first.setBackground(Color.LIGHT_GRAY);
		second.setBackground(Color.LIGHT_GRAY);
		third.setBackground(Color.LIGHT_GRAY);
		fourth.setBackground(Color.LIGHT_GRAY);
		
		// Adding all the things
		first.add(name);
		first.add(nameBoxPanel);
		second.add(genre);
		second.add(genreBoxPanel);
		third.add(rating);
		third.add(ratingBoxPanel);
		third.add(outOfTen);
		fourth.add(create);
		
		center.add(first);
		center.add(second);
		center.add(third);
		center.add(fourth);
		
		
	}
	
	
	// Actions
	@Override
	public void actionPerformed(ActionEvent e)
	{
		addButton(e);
		browseButton(e);
		backButton(e);
	}
	
	// Create button
	public void createButton(ActionEvent e)
	{
		String name = e.getActionCommand();
		
		if(name.contentEquals("ADD"))
		{
			String nameInfo = nameBox.getText();
			String genreInfo = genreBox.getText();
			String ratingInfo = ratingBox.getText();
			
			int ratingNum = Integer.parseInt(ratingInfo);
			
			Movie x = new Movie(nameInfo, genreInfo, ratingNum);
			
			catalog.add(x);
		}
	}
	
	// Add page
	public void addButton(ActionEvent e)
	{
		String name = e.getActionCommand();
		
		if(name.contentEquals("Add Movie to Catalog"))
		{
			addMoviePage();
		}
	}
	
	// browse page
	public void browseButton(ActionEvent e)
	{
		String name = e.getActionCommand();
		
		if(name.contentEquals("Browse Movie Catalog"))
		{
			browseMoviesPage();
		}
	}
	
	// back button
	public void backButton(ActionEvent e)
	{
		String name = e.getActionCommand();
		
		if(name.contentEquals("Back"))
		{
			// removing main menu buttons
			panel.removeAll();
			panel.revalidate();
			panel.repaint();
			
			panel.setLayout(new GridLayout(1,2));
			
			//buttons
			panel.add(browse());
			panel.add(addMovie());
		}
	}
	
	
}
