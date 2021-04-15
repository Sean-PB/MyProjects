package finalProject;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.SwingConstants;

public class Window extends JFrame implements ActionListener {
	
	////////////////////////////////////// Constants //////////////////////////////////////////////////////////////
	// Window Size Variables
	public static final int WIDTH = 1000;
	public static final int HEIGHT = 800;
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	////////////////////////////////////// Variables ///////////////////////////////////////
	int unitNum1;
	int unitNum2;
	int numOfUnits1;
	int numOfUnits2;
	
	int ready = 1;
	
	int grandmaNum1 = 0;
	int lionNum1 = 0;
	int mortyNum1 = 0;
	int rickNum1 = 0;
	int spartanNum1 = 0;
	int zombieNum1 = 0;
	
	int grandmaNum2 = 0;
	int lionNum2 = 0;
	int mortyNum2 = 0;
	int rickNum2 = 0;
	int spartanNum2 = 0;
	int zombieNum2 = 0;
	
	int unitAttack1;
	int unitDefense1;
	int unitHealth1;
	
	int unitAttack2;
	int unitDefense2;
	int unitHealth2;
	////////////////////////////////////////////////////////////////////////////////////////
	
	
	//////////////////////////////////// JTextFields //////////////////////////////////////////////////////////////
	JTextField team1GrandmaNum = new JTextField(10);
	JTextField team1LionNum = new JTextField(4);
	JTextField team1MortyNum = new JTextField(4);
	JTextField team1RickNum = new JTextField(4);
	JTextField team1SpartanNum = new JTextField(4);
	JTextField team1ZombieNum = new JTextField(4);
	

	JTextField team2GrandmaNum = new JTextField(4);
	JTextField team2LionNum = new JTextField(4);
	JTextField team2MortyNum = new JTextField(4);
	JTextField team2RickNum = new JTextField(4);
	JTextField team2SpartanNum = new JTextField(4);
	JTextField team2ZombieNum = new JTextField(4);
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	////////////////////////////////// Creating the teams///////////////////////////////////
	Team<Unit> team1 = new Team<Unit>();
	Team<Unit> team2 = new Team<Unit>();
	///////////////////////////////////////////////////////////////////////////////////////
	
	
	///////////////////////////////// Units ///////////////////////////////////////////////////////////////////////
	// Creating the units that will be null until selected
	Unit<Warrior> team1Unit1 = new Unit<Warrior>();
	Unit<Warrior> team1Unit2 = new Unit<Warrior>();
	Unit<Warrior> team1Unit3 = new Unit<Warrior>();
	Unit<Warrior> team2Unit1 = new Unit<Warrior>();
	Unit<Warrior> team2Unit2 = new Unit<Warrior>();
	Unit<Warrior> team2Unit3 = new Unit<Warrior>();
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	////////////////////////////////// JPanels /////////////////////////////////////////////
	JPanel center = new JPanel();
	
	JPanel topMiddle = new JPanel();
	
	JPanel middleLeft = new JPanel();
	JPanel middleRight = new JPanel();
	JPanel menuPanel1 = new JPanel();
	JPanel menuPanel2 = new JPanel();
	
	JPanel bottomLeft = new JPanel();
	JPanel bottomRight = new JPanel();

	JPanel south = new JPanel();
	JPanel southLeft = new JPanel();
	JPanel survivorsPanel = new JPanel();
	/////////////////////////////////////////////////////////////////////////////////////////
	
	
	/////////////////////////////////// JButtons /////////////////////////////////////////////////////////////////
	JButton statsButton = new JButton();
	JButton showPreviousBattles = new JButton();
	JButton battleButton = new JButton();
	JButton saveBattle = new JButton();
	JButton showSurvivors = new JButton();
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	/////////////////////////////////// JMenuItems //////////////////////////////////////////
	// How many units
	JMenuItem one = new JMenuItem("1 Unit");
	JMenuItem two = new JMenuItem("2 Units");
	JMenuItem three = new JMenuItem("3 Units");
	JMenuItem uno = new JMenuItem("1 unit");
	JMenuItem dos = new JMenuItem("2 units");
	JMenuItem tres = new JMenuItem("3 units");
	//////////////////////////////////////////////////////////////////////////////////////////
	
	
	/////////////////////////////////////// JLabels //////////////////////////////////////////////////////////////
	// Creating headers for the second menus
	JLabel team1TypeHeader = new JLabel("Choose a warrior type for each unit", SwingConstants.CENTER);
	JLabel team2TypeHeader = new JLabel("Choose a warrior type for each unit", SwingConstants.CENTER);
	JLabel winner = new JLabel("", SwingConstants.CENTER);
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	// Building Window
 	Window()
	{
		// Creating the window itself
		super("Battle Simulator");
		setSize(WIDTH, HEIGHT);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setLayout(new BorderLayout());
		
		// Clear teams whenever there is a new window built
		team1.clear();
		team2.clear();
		
		// Add header ("Team 1 and Team 2 upper labels)
		add(buildHeader(), java.awt.BorderLayout.NORTH);
		
		// Add the center and make it a grid layout
		add(center, java.awt.BorderLayout.CENTER);
		center.setLayout(new GridLayout(3, 3));
		
		/////////////////////////// CENTER GRID //////////////////////////////////////////////
		// Add top left
		center.add(buildTopLeft());
		
		// Add top middle
		center.add(topMiddle);
		topMiddle.setBackground(Color.green);
		buildTopMiddle();
		
		// Add top right
		center.add(buildTopRight());
		
		// Add middle left 
		center.add(middleLeft);
		middleLeft.setBackground(Color.cyan);
		middleLeft.setLayout(new BorderLayout());
		
		// Add middle middle (See previously saved battles) ////////NOT DONE/////////
		center.add(showPreviousBattles);
		buildSeePreviousBattles();
		
		// Add middle right 
		center.add(middleRight);
		middleRight.setBackground(Color.yellow);
		middleRight.setLayout(new BorderLayout());
		
		// Add lower left
		center.add(bottomLeft);
		bottomLeft.setBackground(Color.cyan);
		
		// Add lower middle /////////////////////NOT DONE///////////////////////////
		center.add(battleButton);
		buildBattleButton();
		
		// Add lower right
		center.add(bottomRight);
		bottomRight.setBackground(Color.yellow);
		
		//////////////////////////////////////////////////////////////////////////////////////
	}
	
	////////////////////////////////////////////// Build Methods /////////////////////////////////////////////////
	
	// Header builder
	public JPanel buildHeader()
	{
		// Creating the panel and the labels
		JPanel panel = new JPanel();
		panel.setLayout(new GridLayout(1,3));
		JLabel team1 = new JLabel("Team 1", SwingConstants.CENTER);
		JLabel empty = new JLabel();
		JLabel team2 = new JLabel("Team 2", SwingConstants.CENTER);
		// Setting color
		team1.setBackground(Color.cyan);
		empty.setBackground(Color.green);
		team2.setBackground(Color.yellow);
		team1.setOpaque(true);
		empty.setOpaque(true);
		team2.setOpaque(true);
		// Adding Labels to panel
		panel.add(team1);
		panel.add(empty);
		panel.add(team2);
		
		return panel;
	}
	
	// Top left builder (Number of units for team 1)
	public JPanel buildTopLeft()
	{
		// Creating the JPanel that will be returned
		JPanel panel = new JPanel();
		panel.setBackground(Color.cyan);
		
		// Creating the menu and menu items
		JMenuBar menuBar = new JMenuBar();
		JMenu menu = new JMenu("Number of Units for Team 1 V");
		one.addActionListener(this);
		two.addActionListener(this);
		three.addActionListener(this);
		
		// Adding menuItems to menu
		menu.add(one);
		menu.add(two);
		menu.add(three);
		
		// Adding menu to panel
		menuBar.add(menu);
		panel.add(menuBar);
		
		return panel;
	}
	
	// Top Middle Builder (Stats)
	public void buildTopMiddle()
	{
		topMiddle.setLayout(new BorderLayout());

		// Creating button
		statsButton.setText("Show Warrior Stats");
		statsButton.addActionListener(this);
		
		// Adding button
		topMiddle.add(statsButton, java.awt.BorderLayout.NORTH);
		
	}
	
	// Top right builder (Number of units for team 2)
	public JPanel buildTopRight()
	{

		// Creating the JPanel that will be returned
		JPanel panel = new JPanel();
		panel.setBackground(Color.yellow);
		
		// Creating the menu and menu items
		JMenuBar menuBar = new JMenuBar();
		JMenu menu = new JMenu("Number of Units for Team 2 V");
		uno.addActionListener(this);
		dos.addActionListener(this);
		tres.addActionListener(this);
		
		// Adding menuItems to menu
		menu.add(uno);
		menu.add(dos);
		menu.add(tres);
		
		// Adding menu to panel
		menuBar.add(menu);
		panel.add(menuBar);
		
		return panel;
	}
	
	// Warrior Menu Builder for team 1
	public JMenuBar team1WarriorMenu()
	{
		// Creating menu and menubar
		JMenuBar menuBar = new JMenuBar();
		JMenu menu = new JMenu("Warrior Types");
		
		// Warrior types for team 1
		JMenuItem grandma1 = new JMenuItem("Grandma");
		JMenuItem lion1 = new JMenuItem("Lion");
		JMenuItem morty1 = new JMenuItem("Morty");
		JMenuItem rick1 = new JMenuItem("Rick");
		JMenuItem spartan1 = new JMenuItem("Spartan");
		JMenuItem zombie1 = new JMenuItem("Zombie");
		
		// Adding team 1 warrior types
		menu.add(grandma1);
		menu.add(lion1);
		menu.add(morty1);
		menu.add(rick1);
		menu.add(spartan1);
		menu.add(zombie1);
		
		// Adding action listeners
		grandma1.addActionListener(this);
		lion1.addActionListener(this);
		morty1.addActionListener(this);
		rick1.addActionListener(this);
		spartan1.addActionListener(this);
		zombie1.addActionListener(this);
		
		// Adding menu to menuBar
		menuBar.add(menu);
		
		return menuBar;
	}
	
	// Warrior Menu Builder for team2
	public JMenuBar team2WarriorMenu()
	{
		// Creating menu and menubar
		JMenuBar menuBar = new JMenuBar();
		JMenu menu = new JMenu("Warrior Types");

		// Warrior types for team 2 (these have spaces at the end of them so I can later distinguish what menuBar they came from)
		JMenuItem grandma2 = new JMenuItem("Grandma ");
		JMenuItem lion2 = new JMenuItem("Lion ");
		JMenuItem morty2 = new JMenuItem("Morty ");
		JMenuItem rick2 = new JMenuItem("Rick ");
		JMenuItem spartan2 = new JMenuItem("Spartan ");
		JMenuItem zombie2 = new JMenuItem("Zombie ");
		
		
		// Adding team 2 warrior types
		menu.add(grandma2);
		menu.add(lion2);
		menu.add(morty2);
		menu.add(rick2);
		menu.add(spartan2);
		menu.add(zombie2);
		
		// Adding action listeners
		grandma2.addActionListener(this);
		lion2.addActionListener(this);
		morty2.addActionListener(this);
		rick2.addActionListener(this);
		spartan2.addActionListener(this);
		zombie2.addActionListener(this);
		
		// Adding menu to menuBar
		menuBar.add(menu);
		
		return menuBar;
		
	}
	
	// Build battle button
	public void buildBattleButton()
	{
		battleButton.setBackground(Color.red);
		battleButton.setText("BATTLE");
		battleButton.addActionListener(this);
	}
	
	// Build see previously saved battles button
	public void buildSeePreviousBattles()
	{
		showPreviousBattles.setBackground(Color.orange);
		showPreviousBattles.setText("Show Previously Saved Battles");
		showPreviousBattles.addActionListener(this);
	}
	
	// Build show Survivors button
	public JPanel buildShowSurvivors()
	{
		// building panel
		southLeft.setLayout(new BorderLayout());
		southLeft.setBackground(Color.DARK_GRAY);
		
		// building button
		showSurvivors.setText("Show Survivors");
		southLeft.add(showSurvivors, java.awt.BorderLayout.NORTH);
		showSurvivors.addActionListener(this);
		
		
		return southLeft;
	}
	
	// Build bottom
	public JPanel buildBottom()
	{
		// Creating the panels
		south.setLayout(new GridLayout(1, 3));
		south.setPreferredSize(new Dimension(WIDTH, 100));
		south.setBorder(BorderFactory.createLineBorder(Color.black, 1));
		// If both teams have at least 1 warrior
		if (ready == 3)
		{	
			// Show survivors
			south.add(buildShowSurvivors());
			
			// See winner
			south.add(winner);
			
			// Save battle
			buildSave();
			south.add(saveBattle);
			
			// Make sure battleButton isnt pressed again so there wont be any errors
			battleButton.removeActionListener(this);
			
			return south;
		}
		// If either team has less than 1 warrior
		else if (ready == 1)
		{
			winner.setBackground(Color.gray);
			winner.setOpaque(true);
			winner.setText("Pleas enter at least one warrior per team and try again.");
			south.add(winner);
			
			return south;
		}
		else if (ready == 2)
		{
			winner.setText("Only enter whole numbers into the text field. Please try again");
			south.add(winner);
			
			return south;
		}
		else
			return south;
		
	}
	
	// Build Save battle button
	public void buildSave()
	{
		saveBattle.setBackground(Color.orange);
		saveBattle.addActionListener(this);
		saveBattle.setText("Save Battle");
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	///////////////////////////////////// Battle Methods //////////////////////////////////////////////////////////
	
	// To find the fastest unit in a given team
	public Unit<Warrior> findFastest(Team<Unit> x) throws NullPointerException
	{
		// Speed variables
		int speed1 = 0;
		int speed2 = 0;
		int speed3 = 0;
		
		// Creating null unit variables
		Unit<Warrior> firstUnit = null;
		Unit<Warrior> secondUnit = null;
		Unit<Warrior> thirdUnit = null;
		
		// Team size so we know how many units to create
		int size = x.size();
		
		// Creating the correct number of units in the team
		if (size == 1)
		{
			firstUnit = (Unit<Warrior>) x.get(0);
		}
		if (size == 2)
		{
			firstUnit = (Unit<Warrior>) x.get(0);
			secondUnit = (Unit<Warrior>) x.get(1);
		}
		if (size == 3)
		{
			secondUnit = (Unit<Warrior>) x.get(1);
			firstUnit = (Unit<Warrior>) x.get(0);
			thirdUnit = (Unit<Warrior>) x .get(2);
		}
			
		// Find the speed for each unit by finding the speed for that unit's warrior type
		if (firstUnit == null)
			speed1 = 0;
		else
			speed1 = firstUnit.get(0).getSpeed();
		
		
		if (secondUnit == null)
			speed2 = 0;
		else
			speed2 = secondUnit.get(0).getSpeed();
		
		
		if (thirdUnit == null)
			speed3 = 0;
		else
			speed3 = thirdUnit.get(0).getSpeed();
		
		
		// Return the fastest of the bunch
		// If unit 1 is the fastest
		if (speed1 > speed2 && speed1 > speed3)
			return firstUnit;
		// If unit 2 is the fastest
		else if (speed2 > speed1 && speed2 > speed3)
			return secondUnit;
		// If unit 3 is the fastest
		else if (speed3 > speed1 && speed3 > speed1)
			return thirdUnit;
		// If unit 1 is equal to unit 3 and both are faster than unit three, return unit 1
		else if (speed1 == speed2 && speed2 > speed3)
			return firstUnit;
		// If unit 2 == unit 3 and both are faster than unit 1, return unit 2
		else
			return secondUnit;
		
	}
	
	// Finds fastest unit out of both teams fastest units
	public Unit<Warrior> whosFirst(Unit<Warrior> one, Unit<Warrior> two)
	{
		// Find the speed of each teams fastest units
		int speed1 = one.get(0).getSpeed();
		int speed2 = two.get(0).getSpeed();
		
		// If team 1's fastest unit is faster
		if(speed1 > speed2)
			return one;
		// If team 2's fastest unit is faster
		else if(speed1 < speed2)
			return two;
		// If they are tied, return team 1's fastest unit
		else
			return one;
	}
	
	// Finds the slowest unit out of both teams fastest units
	public Unit<Warrior> whosSecond(Unit<Warrior> one, Unit<Warrior> two)
	{
		// Find the speed of each teams fastest units
		int speed1 = one.get(0).getSpeed();
		int speed2 = two.get(0).getSpeed();
		
		// If team 1's fastest unit is faster
		if(speed1 > speed2)
			return two;
		// If team 2's fastest unit is faster
		else if(speed1 < speed2)
			return one;
		// If they are tied, return team 2's fastest unit
		else
			return two;
	}
	
	
	// Finds the stats for each warrior in a unit and pools them together to create unit stats
	public int unitAttack(Unit<Warrior>	unit)
	{
		Warrior warriror = unit.get(0);
		
		return (warriror.getAttack() * unit.size());
	}
	public int unitHealth(Unit<Warrior> unit)
	{
		Warrior warrior = unit.get(0);
		
		return (warrior.getHealth() * unit.size());
	}
	
	// Unit battle
	public void unitBattle()
	{
		// Finds the next fastest unit in each team
		Unit<Warrior> team1Fastest = findFastest(team1);
		Unit<Warrior> team2Fastest = findFastest(team2);
		
		// Find out what team will strike first
		Unit<Warrior> first = whosFirst(team1Fastest, team2Fastest);
		Unit<Warrior> second = whosSecond(team1Fastest, team2Fastest);
		
		// Gets the individual unit stats
		int firstAttack = unitAttack(first);
		int firstHealth = unitHealth(first);
		int secondAttack = unitAttack(second);
		int secondHealth = unitHealth(second);
		
		// Have them fight unit one of their health is at or below 0
		while(firstHealth > 0 && secondHealth > 0)
		{
			secondHealth -= firstAttack;
			
			if (secondHealth > 0)
				firstHealth -= secondAttack;
		}
		
		// Removing winning units dead warriors
		// Find out who won and how many warriors they lost. Take the warrior model's health and divide the units total (original) health then subtract that number by the
		// remaining health. That number is how many warriors the unit died. Remove that many warriors.
		if (firstHealth > 0)
		{
			// Find out how many warriors died
			int dead = (int) first.size() - (firstHealth / first.get(0).getHealth());
			
			// If there is only one person left and they are injured, don't remove them.
			if (dead != first.size())
			{
				// Remove that many warriors from the unit permanently
				for (int i = 0; i < dead; i++)
					first.remove(first.get(0));
			}
			
		}
		else if (secondHealth > 0)
		{
			// Find out how many warriors died
			int dead = (int) second.size() - (secondHealth / second.get(0).getHealth());

			// If there is only one person left and they are injured, don't remove them
			if (dead != second.size())
			{
				// Remove that many warriors from the unit permanently
				for (int i = 0; i < dead; i++)
					second.remove(second.get(0));
			}
			
		}
		
		// Find out who lost, clear their unit and return them
		if (firstHealth < 1)
		{
			first.clear();
		}
		else
		{
			second.clear();
		}
		
	}
	
	// Team battle (Recursive)
	public void battle()
	{
		// Finds and removes dead units
		if (team1Unit1.isEmpty() == true)
			team1.remove(team1Unit1);
		
		if (team1Unit2.isEmpty() == true)
			team1.remove(team1Unit2);
		
		if (team1Unit3.isEmpty() == true)
			team1.remove(team1Unit3);
		
		if (team2Unit1.isEmpty() == true)
			team2.remove(team2Unit1);
		
		if (team2Unit2.isEmpty() == true)
			team2.remove(team2Unit2);
		
		if (team2Unit3.isEmpty() == true)
			team2.remove(team2Unit3);
		
		// Base case 1
		// If team 2 is empty, team 1 wins
		if(team2.size() == 0)
		{
			winner.setBackground(Color.cyan);
			winner.setOpaque(true);
			winner.setText("Team 1 Wins!");
		}
		// Base case 2
		// If team 1 is empty, team 2 wins
		else if(team1.size() == 0)
		{
			winner.setBackground(Color.yellow);
			winner.setOpaque(true);
			winner.setText("Team 2 Wins!");
		}
		// If neither are empty, have their fastest remaining units battle until one of them is removed and run this method again to look for winner again
		else
		{
			try
			{
				unitBattle();
			}
			catch (NullPointerException exception)
			{
				
			}

			battle();
		}
		
	}
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	//////////////////////////////////// Actions //////////////////////////////////////////////////
	
	@Override
	public void actionPerformed(ActionEvent e) 
	{
		// First menus
		unitMenu(e);
		
		// Second menus
		warriorMenu(e);
		
		// Show stats
		showStats(e);
		
		// Show survivors
		showSurvivors(e);
		
		// Show previous battles
		// seePrevious(e);

		// Battle
		battleButton(e);
		
		// Save battle
		
		
		
		setVisible(true);
	}
	
	// When the button to show stats is pushed do this
	public void showStats(ActionEvent e)
	{
		String button = e.getActionCommand();
		
		// Creating panel
		JPanel panel = new JPanel();
		panel.setLayout(new GridLayout(6, 1));
		panel.setBackground(Color.green);

		// Creating JLabels
		JLabel grandmaStats = new JLabel("Grandma  =  | Speed: 1 | Attack: 10 | Health: 60 |");
		JLabel lionStats = new JLabel("Lion  =  | Speed: 6 | Attack: 40 | Health: 75 |");
		JLabel mortyStats = new JLabel("Morty  =   | Speed: 4 | Attack: 25 | Health: 70 |");
		JLabel rickStats = new JLabel("Rick  =  | Speed: 2 | Attack: 100  | Health: 90 |");
		JLabel spartanStats = new JLabel("Spartan  =  | Speed: 5 | Attack: 35 | Health: 80 |");
		JLabel zombieStats = new JLabel("Zombie  =  | Speed: 3 | Attack: 25 | Health: 100 |");
		
		panel.add(grandmaStats);
		panel.add(lionStats);
		panel.add(rickStats);
		panel.add(mortyStats);
		panel.add(spartanStats);
		panel.add(zombieStats);
		
		
		if (button.contentEquals("Show Warrior Stats"))
		{
			// Adding stats
			topMiddle.add(panel, java.awt.BorderLayout.CENTER);
			
			// Switching button text
			statsButton.setText("Hide Warrior Stats");
		}
		else if (button.contentEquals("Hide Warrior Stats"))
		{
			// Removing stats
			topMiddle.removeAll();
			topMiddle.revalidate();
			topMiddle.repaint();
			
			// Switching button text back
			topMiddle.add(statsButton, java.awt.BorderLayout.NORTH);
			statsButton.setText("Show Warrior Stats");

		}
	}

	// The first menus (how many units)
	public void unitMenu(ActionEvent e)
	{
		// Finding out which menuItem was chosen
		Object unitsChosen = e.getSource();
		
		
		// Adding panel to the center where the menus will be placed
		middleLeft.add(menuPanel1, java.awt.BorderLayout.CENTER);
		menuPanel1.setLayout(new FlowLayout());
		menuPanel1.setBackground(Color.cyan);
		
		middleRight.add(menuPanel2, java.awt.BorderLayout.CENTER);
		menuPanel2.setLayout(new FlowLayout());
		menuPanel2.setBackground(Color.yellow);
		
		
		// Team 1
		if (unitsChosen == one)
		{
			unitNum1 = 1;
			numOfUnits1 = 1;
			
			
			middleLeft.add(team1TypeHeader, java.awt.BorderLayout.NORTH);
			
			
			// In case the user changes their mind about how many units they want, clear the previous Warrior menus and text areas
			menuPanel1.removeAll();
			menuPanel1.revalidate();
			menuPanel1.repaint();
			bottomLeft.removeAll();
			bottomLeft.revalidate();
			bottomLeft.repaint();
			
			
			// Add the menus to the next panel down
			for(int i = 0; i < unitNum1; i++)
			{
				menuPanel1.add(team1WarriorMenu());
			}
			
		}
		else if (unitsChosen == two)
		{
			unitNum1 = 2;
			numOfUnits1 = 2;
			
			middleLeft.add(team1TypeHeader, java.awt.BorderLayout.NORTH);

			// In case the user changes their mind about how many units they want, clear the previous Warrior menus and text areas
			menuPanel1.removeAll();
			menuPanel1.revalidate();
			menuPanel1.repaint();
			bottomLeft.removeAll();
			bottomLeft.revalidate();
			bottomLeft.repaint();

			// Add the menus to the next panel down
			for(int i = 0; i < unitNum1; i++)
			{
				menuPanel1.add(team1WarriorMenu());
			}
		}
		else if (unitsChosen == three)
		{
			unitNum1 = 3;
			numOfUnits1 = 3;
			
			middleLeft.add(team1TypeHeader, java.awt.BorderLayout.NORTH);

			// In case the user changes their mind about how many units they want, clear the previous Warrior menus and text areas
			menuPanel1.removeAll();
			menuPanel1.revalidate();
			menuPanel1.repaint();
			bottomLeft.removeAll();
			bottomLeft.revalidate();
			bottomLeft.repaint();

			// Add the menus to the next panel down
			for(int i = 0; i < unitNum1; i++)
			{
				menuPanel1.add(team1WarriorMenu());
			}
		}
		
		// Team 2
		if (unitsChosen == uno)
		{
			unitNum2 = 1;
			numOfUnits2 = 1;
			
			middleRight.add(team2TypeHeader, java.awt.BorderLayout.NORTH);
			
			// In case the user changes their mind about how many units they want, clear the previous Warrior menus and text areas
			menuPanel2.removeAll();
			menuPanel2.revalidate();
			menuPanel2.repaint();
			bottomRight.removeAll();
			bottomRight.revalidate();
			bottomRight.repaint();

			// Add the menus to the next panel down
			for(int i = 0; i < unitNum2; i++)
			{
				menuPanel2.add(team2WarriorMenu());
			}
		}
		else if (unitsChosen == dos)
		{
			unitNum2 = 2;
			numOfUnits2 = 2;
			
			middleRight.add(team2TypeHeader, java.awt.BorderLayout.NORTH);

			// In case the user changes their mind about how many units they want, clear the previous Warrior menus and text areas
			menuPanel2.removeAll();
			menuPanel2.revalidate();
			menuPanel2.repaint();
			bottomRight.removeAll();
			bottomRight.revalidate();
			bottomRight.repaint();

			// Add the menus to the next panel down
			for(int i = 0; i < unitNum2; i++)
			{
				menuPanel2.add(team2WarriorMenu());
			}
		}
		else if (unitsChosen == tres)
		{
			unitNum2 = 3;
			numOfUnits2 = 3;
			
			middleRight.add(team2TypeHeader, java.awt.BorderLayout.NORTH);

			// In case the user changes their mind about how many units they want, clear the previous Warrior menus and text areas
			menuPanel2.removeAll();
			menuPanel2.revalidate();
			menuPanel2.repaint();
			bottomRight.removeAll();
			bottomRight.revalidate();
			bottomRight.repaint();

			// Add the menus to the next panel down
			for(int i = 0; i < unitNum2; i++)
			{
				menuPanel2.add(team2WarriorMenu());
			}
		}
	}
	
	// Second menu (what kind of warriors)
	public void warriorMenu(ActionEvent e)
	{
		// Finding out which menuItem was chosen
		String warriorChosen = e.getActionCommand();
		
		// Setting layouts for the panels
		bottomLeft.setLayout(new FlowLayout(FlowLayout.TRAILING, 45, 5));
		bottomRight.setLayout(new FlowLayout(FlowLayout.TRAILING, 45, 5));
		
		// Team 1
		if (warriorChosen.contentEquals("Grandma"))
		{
			// Remove 1 of the unitMenus
			menuPanel1.removeAll();
			menuPanel1.revalidate();
			menuPanel1.repaint();
			unitNum1--;
			for(int i = 0; i < unitNum1; i++)
			{
				menuPanel1.add(team1WarriorMenu());
			}
			
			// If there are no more warrior menus remove the instruction label
			if(unitNum1 < 1)
			{
				middleLeft.remove(team1TypeHeader);
			}
			
			// Add label
			bottomLeft.add(new JLabel("How many Grandmas?"));
			
			// Add text field
			bottomLeft.add(team1GrandmaNum);
			team1GrandmaNum.setDocument(new JTextFieldLimit(4));
		}
		else if (warriorChosen.contentEquals("Lion"))
		{
			// Remove 1 of the unitMenus
			menuPanel1.removeAll();
			menuPanel1.revalidate();
			menuPanel1.repaint();
			unitNum1--;
			for(int i = 0; i < unitNum1; i++)
			{
				menuPanel1.add(team1WarriorMenu());
			}

			// If there are no more warrior menus remove the instruction label
			if(unitNum1 < 1)
			{
				middleLeft.remove(team1TypeHeader);
			}
			
			// Add label
			bottomLeft.add(new JLabel("How many Lions?"));
			
			// Add text field
			bottomLeft.add(team1LionNum);
			team1LionNum.setDocument(new JTextFieldLimit(4));
			
		}
		else if (warriorChosen.contentEquals("Morty"))
		{
			// Remove 1 of the unitMenus
			menuPanel1.removeAll();
			menuPanel1.revalidate();
			menuPanel1.repaint();
			unitNum1--;
			for(int i = 0; i < unitNum1; i++)
			{
				menuPanel1.add(team1WarriorMenu());
			}

			// If there are no more warrior menus remove the instruction label
			if(unitNum1 < 1)
			{
				middleLeft.remove(team1TypeHeader);
			}
			
			// Add label
			bottomLeft.add(new JLabel("How many Mortys?"));
			
			// Add text field
			bottomLeft.add(team1MortyNum);
			team1MortyNum.setDocument(new JTextFieldLimit(4));
			
		}
		else if (warriorChosen.contentEquals("Rick"))
		{
			// Remove 1 of the unitMenus
			menuPanel1.removeAll();
			menuPanel1.revalidate();
			menuPanel1.repaint();
			unitNum1--;
			for(int i = 0; i < unitNum1; i++)
			{
				menuPanel1.add(team1WarriorMenu());
			}

			// If there are no more warrior menus remove the instruction label
			if(unitNum1 < 1)
			{
				middleLeft.remove(team1TypeHeader);
			}
			
			// Add label
			bottomLeft.add(new JLabel("How many Ricks?"));
			
			// Add text field
			bottomLeft.add(team1RickNum);
			team1RickNum.setDocument(new JTextFieldLimit(4));
			
		}
		else if (warriorChosen.contentEquals("Spartan"))
		{
			// Remove 1 of the unitMenus
			menuPanel1.removeAll();
			menuPanel1.revalidate();
			menuPanel1.repaint();
			unitNum1--;
			for(int i = 0; i < unitNum1; i++)
			{
				menuPanel1.add(team1WarriorMenu());
			}

			// If there are no more warrior menus remove the instruction label
			if(unitNum1 < 1)
			{
				middleLeft.remove(team1TypeHeader);
			}
			
			// Add label
			bottomLeft.add(new JLabel("How many Spartans?"));
			
			// Add text field
			bottomLeft.add(team1SpartanNum);
			team1SpartanNum.setDocument(new JTextFieldLimit(4));
			
		}
		else if (warriorChosen.contentEquals("Zombie"))
		{
			// Remove 1 of the unitMenus
			menuPanel1.removeAll();
			menuPanel1.revalidate();
			menuPanel1.repaint();
			unitNum1--;
			for(int i = 0; i < unitNum1; i++)
			{
				menuPanel1.add(team1WarriorMenu());
			}

			// If there are no more warrior menus remove the instruction label
			if(unitNum1 < 1)
			{
				middleLeft.remove(team1TypeHeader);
			}
			
			// Add label
			bottomLeft.add(new JLabel("How many Zombies?"));
			
			// Add text field
			bottomLeft.add(team1ZombieNum);
			team1ZombieNum.setDocument(new JTextFieldLimit(4));
			
		}
		
		// Team 2
		if (warriorChosen.contentEquals("Grandma "))
		{
			// Remove 1 of the unitMenus
			menuPanel2.removeAll();
			menuPanel2.revalidate();
			menuPanel2.repaint();
			unitNum2--;
			for(int i = 0; i < unitNum2; i++)
			{
				menuPanel2.add(team2WarriorMenu());
			}

			// If there are no more warrior menus remove the instruction label
			if(unitNum2 < 1)
			{
				middleRight.remove(team2TypeHeader);
			}
			
			// Add label
			bottomRight.add(new JLabel("How many Grandmas?"));
			
			// Add text field
			bottomRight.add(team2GrandmaNum);
			team2GrandmaNum.setDocument(new JTextFieldLimit(4));
			
		}
		else if (warriorChosen.contentEquals("Lion "))
		{
			// Remove 1 of the unitMenus
			menuPanel2.removeAll();
			menuPanel2.revalidate();
			menuPanel2.repaint();
			unitNum2--;
			for(int i = 0; i < unitNum2; i++)
			{
				menuPanel2.add(team2WarriorMenu());
			}

			// If there are no more warrior menus remove the instruction label
			if(unitNum2 < 1)
			{
				middleRight.remove(team2TypeHeader);
			}
			
			// Add label
			bottomRight.add(new JLabel("How many Lions?"));
			
			// Add text field
			bottomRight.add(team2LionNum);
			team2LionNum.setDocument(new JTextFieldLimit(4));
			
		}
		else if (warriorChosen.contentEquals("Morty "))
		{
			// Remove 1 of the unitMenus
			menuPanel2.removeAll();
			menuPanel2.revalidate();
			menuPanel2.repaint();
			unitNum2--;
			for(int i = 0; i < unitNum2; i++)
			{
				menuPanel2.add(team2WarriorMenu());
			}

			// If there are no more warrior menus remove the instruction label
			if(unitNum2 < 1)
			{
				middleRight.remove(team2TypeHeader);
			}
			
			// Add label
			bottomRight.add(new JLabel("How many Mortys?"));
			
			// Add text field
			bottomRight.add(team2MortyNum);
			team2MortyNum.setDocument(new JTextFieldLimit(4));
			
		}
		else if (warriorChosen.contentEquals("Rick "))
		{
			// Remove 1 of the unitMenus
			menuPanel2.removeAll();
			menuPanel2.revalidate();
			menuPanel2.repaint();
			unitNum2--;
			for(int i = 0; i < unitNum2; i++)
			{
				menuPanel2.add(team2WarriorMenu());
			}

			// If there are no more warrior menus remove the instruction label
			if(unitNum2 < 1)
			{
				middleRight.remove(team2TypeHeader);
			}
			
			// Add label
			bottomRight.add(new JLabel("How many Ricks?"));
			
			// Add text field
			bottomRight.add(team2RickNum);
			team2RickNum.setDocument(new JTextFieldLimit(4));
			
		}
		else if (warriorChosen.contentEquals("Spartan "))
		{
			// Remove 1 of the unitMenus
			menuPanel2.removeAll();
			menuPanel2.revalidate();
			menuPanel2.repaint();
			unitNum2--;
			for(int i = 0; i < unitNum2; i++)
			{
				menuPanel2.add(team2WarriorMenu());
			}

			// If there are no more warrior menus remove the instruction label
			if(unitNum2 < 1)
			{
				middleRight.remove(team2TypeHeader);
			}
			
			// Add label
			bottomRight.add(new JLabel("How many Spartans?"));
			
			// Add text field
			bottomRight.add(team2SpartanNum);
			team2SpartanNum.setDocument(new JTextFieldLimit(4));
			
		}
		else if (warriorChosen.contentEquals("Zombie "))
		{
			// Remove 1 of the unitMenus
			menuPanel2.removeAll();
			menuPanel2.revalidate();
			menuPanel2.repaint();
			unitNum2--;
			for(int i = 0; i < unitNum2; i++)
			{
				menuPanel2.add(team2WarriorMenu());
			}
			
			// If there are no more warrior menus remove the instruction label
			if(unitNum2 < 1)
			{
				middleRight.remove(team2TypeHeader);
			}
			
			// Add label
			bottomRight.add(new JLabel("How many Zombies?"));
			
			// Add text field
			bottomRight.add(team2ZombieNum);
			team2ZombieNum.setDocument(new JTextFieldLimit(4));
			
		}
		
		
	}
	
	// Battle button
	public void battleButton(ActionEvent e)
	{
		Object button = e.getSource();
		
		if (button == battleButton)
		{
			try
			{
				// Find out how many of each warrior to add to a unit
				if (team1GrandmaNum.getText().contentEquals(""))
					grandmaNum1 = 0;
				else
					grandmaNum1 = Integer.parseInt(team1GrandmaNum.getText());
				
				if (team1LionNum.getText().contentEquals(""))
					lionNum1 = 0;
				else
					lionNum1 = Integer.parseInt(team1LionNum.getText());
				
				if (team1MortyNum.getText().contentEquals(""))
					mortyNum1 = 0;
				else
					mortyNum1 = Integer.parseInt(team1MortyNum.getText());
				
				if (team1RickNum.getText().contentEquals(""))
					rickNum1 = 0;
				else
					rickNum1 = Integer.parseInt(team1RickNum.getText());
				
				if (team1SpartanNum.getText().contentEquals(""))
					spartanNum1 = 0;
				else
					spartanNum1 = Integer.parseInt(team1SpartanNum.getText());
				
				if (team1ZombieNum.getText().contentEquals(""))
					zombieNum1 = 0;
				else
					zombieNum1 = Integer.parseInt(team1ZombieNum.getText());
				
				
				if (team2GrandmaNum.getText().contentEquals(""))
					grandmaNum2 = 0;
				else
					grandmaNum2 = Integer.parseInt(team2GrandmaNum.getText());
				
				if (team2LionNum.getText().contentEquals(""))
					lionNum2 = 0;
				else
					lionNum2 = Integer.parseInt(team2LionNum.getText());
				
				if (team2MortyNum.getText().contentEquals(""))
					mortyNum2 = 0;
				else
					mortyNum2 = Integer.parseInt(team2MortyNum.getText());
				
				if (team2RickNum.getText().contentEquals(""))
					rickNum2 = 0;
				else
					rickNum2 = Integer.parseInt(team2RickNum.getText());
				
				if (team2SpartanNum.getText().contentEquals(""))
					spartanNum2 = 0;
				else
					spartanNum2 = Integer.parseInt(team2SpartanNum.getText());
				
				if (team2ZombieNum.getText().contentEquals(""))
					zombieNum2 = 0;
				else
					zombieNum2 = Integer.parseInt(team2ZombieNum.getText());
			}
			catch(NumberFormatException error)
			{
				ready = 2;
			}
			
			// Create teams
			createTeams();
			
			// Determine if each team has at least 1 warrior
			if( (team1.size() > 0 && team2.size() > 0) && (team1Unit1.size() > 0 && team2Unit1.size() > 0) )
			{
				ready = 3;
			}
			
			
			// Calculating winner
			if (ready == 3)
			{
				battle();
			}
			
			// Build out the bottom to show results
			add(buildBottom(), java.awt.BorderLayout.SOUTH);
		}
	}
	
	// Creates teams
	public void createTeams()
	{

		// Create the specified units for each team and add to correct team ////////////////////////////////////////////////////////

		// Team 1 //////////////////////////////////////////////////////////////////////////////////////////////
		// One unit
		if(numOfUnits1 == 1)
		{
			team1.add(team1Unit1);
			// Clear the unit just in case
			team1Unit1.clear();
			
			// Go through the warriorNums to find whatever doesnt have 0. 
			// Create the warrior that doesnt have 0.
			// Add it however many times to the first empty unit.

			// Add to unit 1
			if (grandmaNum1 > 0)
			{
				Warrior grandma = new Warrior("Grandma");
				for (int i = 0; i < grandmaNum1; i++)
					team1Unit1.add(grandma);
				
				grandmaNum1 = 0;
			}
			else if (lionNum1 > 0)
			{
				Warrior lion = new Warrior("Lion");
				for (int i = 0; i < lionNum1; i++)
					team1Unit1.add(lion);
				
				lionNum1 = 0;
			}
			else if (mortyNum1 > 0)
			{
				Warrior morty = new Warrior("Morty");
				for (int i = 0; i < mortyNum1; i++)
					team1Unit1.add(morty);
				
				mortyNum1 = 0;
			}
			else if (rickNum1 > 0)
			{
				Warrior rick = new Warrior("Rick");
				for (int i = 0; i < rickNum1; i++)
					team1Unit1.add(rick);
				
				rickNum1 = 0;
			}
			else if (spartanNum1 > 0)
			{
				Warrior spartan = new Warrior("Spartan");
				for (int i = 0; i < spartanNum1; i++)
					team1Unit1.add(spartan);
				
				spartanNum1 = 0;
			}
			else if (zombieNum1 > 0)
			{
				Warrior zombie = new Warrior("Zombie");
				for (int i = 0; i < zombieNum1; i++)
					team1Unit1.add(zombie);
				
				zombieNum1 = 0;
			}
				
		}
		
		// Two units
		else if(numOfUnits1 == 2)
		{
			team1.add(team1Unit1);
			team1.add(team1Unit2);
			// Clear the unit just in case
			team1Unit1.clear();
			team1Unit2.clear();
			
			// Add to unit 1
			if (grandmaNum1 > 0)
			{
				Warrior grandma = new Warrior("Grandma");
				for (int i = 0; i < grandmaNum1; i++)
					team1Unit1.add(grandma);
				
				grandmaNum1 = 0;
			}
			else if (lionNum1 > 0)
			{
				Warrior lion = new Warrior("Lion");
				for (int i = 0; i < lionNum1; i++)
					team1Unit1.add(lion);
				
				lionNum1 = 0;
			}
			else if (mortyNum1 > 0)
			{
				Warrior morty = new Warrior("Morty");
				for (int i = 0; i < mortyNum1; i++)
					team1Unit1.add(morty);
				
				mortyNum1 = 0;
			}
			else if (rickNum1 > 0)
			{
				Warrior rick = new Warrior("Rick");
				for (int i = 0; i < rickNum1; i++)
					team1Unit1.add(rick);
				
				rickNum1 = 0;
			}
			else if (spartanNum1 > 0)
			{
				Warrior spartan = new Warrior("Spartan");
				for (int i = 0; i < spartanNum1; i++)
					team1Unit1.add(spartan);
				
				spartanNum1 = 0;
			}
			else if (zombieNum1 > 0)
			{
				Warrior zombie = new Warrior("Zombie");
				for (int i = 0; i < zombieNum1; i++)
					team1Unit1.add(zombie);
				
				zombieNum1 = 0;
			}
			
			// Add to unit 2
			if (grandmaNum1 > 0)
			{
				Warrior grandma = new Warrior("Grandma");
				for (int i = 0; i < grandmaNum1; i++)
					team1Unit2.add(grandma);
				
				grandmaNum1 = 0;
			}
			else if (lionNum1 > 0)
			{
				Warrior lion = new Warrior("Lion");
				for (int i = 0; i < lionNum1; i++)
					team1Unit2.add(lion);
				
				lionNum1 = 0;
			}
			else if (mortyNum1 > 0)
			{
				Warrior morty = new Warrior("Morty");
				for (int i = 0; i < mortyNum1; i++)
					team1Unit2.add(morty);
				
				mortyNum1 = 0;
			}
			else if (rickNum1 > 0)
			{
				Warrior rick = new Warrior("Rick");
				for (int i = 0; i < rickNum1; i++)
					team1Unit2.add(rick);
				
				rickNum1 = 0;
			}
			else if (spartanNum1 > 0)
			{
				Warrior spartan = new Warrior("Spartan");
				for (int i = 0; i < spartanNum1; i++)
					team1Unit2.add(spartan);
				
				spartanNum1 = 0;
			}
			else if (zombieNum1 > 0)
			{
				Warrior zombie = new Warrior("Zombie");
				for (int i = 0; i < zombieNum1; i++)
					team1Unit2.add(zombie);
				
				zombieNum1 = 0;
			}
			
		}
		
		// Three units
		else if(numOfUnits1 == 3)
		{
			team1.add(team1Unit1);
			team1.add(team1Unit2);
			team1.add(team1Unit3);
			// Clear the unit just in case
			team1Unit1.clear();
			team1Unit2.clear();
			team1Unit3.clear();
			
			// Add to unit 1
			if (grandmaNum1 > 0)
			{
				Warrior grandma = new Warrior("Grandma");
				for (int i = 0; i < grandmaNum1; i++)
					team1Unit1.add(grandma);
				
				grandmaNum1 = 0;
			}
			else if (lionNum1 > 0)
			{
				Warrior lion = new Warrior("Lion");
				for (int i = 0; i < lionNum1; i++)
					team1Unit1.add(lion);
				
				lionNum1 = 0;
			}
			else if (mortyNum1 > 0)
			{
				Warrior morty = new Warrior("Morty");
				for (int i = 0; i < mortyNum1; i++)
					team1Unit1.add(morty);
				
				mortyNum1 = 0;
			}
			else if (rickNum1 > 0)
			{
				Warrior rick = new Warrior("Rick");
				for (int i = 0; i < rickNum1; i++)
					team1Unit1.add(rick);
				
				rickNum1 = 0;
			}
			else if (spartanNum1 > 0)
			{
				Warrior spartan = new Warrior("Spartan");
				for (int i = 0; i < spartanNum1; i++)
					team1Unit1.add(spartan);
				
				spartanNum1 = 0;
			}
			else if (zombieNum1 > 0)
			{
				Warrior zombie = new Warrior("Zombie");
				for (int i = 0; i < zombieNum1; i++)
					team1Unit1.add(zombie);
				
				zombieNum1 = 0;
			}
				
			
			// Add to unit 2
			if (grandmaNum1 > 0)
			{
				Warrior grandma = new Warrior("Grandma");
				for (int i = 0; i < grandmaNum1; i++)
					team1Unit2.add(grandma);
				
				grandmaNum1 = 0;
			}
			else if (lionNum1 > 0)
			{
				Warrior lion = new Warrior("Lion");
				for (int i = 0; i < lionNum1; i++)
					team1Unit2.add(lion);
				
				lionNum1 = 0;
			}
			else if (mortyNum1 > 0)
			{
				Warrior morty = new Warrior("Morty");
				for (int i = 0; i < mortyNum1; i++)
					team1Unit2.add(morty);
				
				mortyNum1 = 0;
			}
			else if (rickNum1 > 0)
			{
				Warrior rick = new Warrior("Rick");
				for (int i = 0; i < rickNum1; i++)
					team1Unit2.add(rick);
				
				rickNum1 = 0;
			}
			else if (spartanNum1 > 0)
			{
				Warrior spartan = new Warrior("Spartan");
				for (int i = 0; i < spartanNum1; i++)
					team1Unit2.add(spartan);
				
				spartanNum1 = 0;
			}
			else if (zombieNum1 > 0)
			{
				Warrior zombie = new Warrior("Zombie");
				for (int i = 0; i < zombieNum1; i++)
					team1Unit2.add(zombie);
				
				zombieNum1 = 0;
			}
			
			
			// Add to unit 3
			if (grandmaNum1 > 0)
			{
				Warrior grandma = new Warrior("Grandma");
				for (int i = 0; i < grandmaNum1; i++)
					team1Unit3.add(grandma);
				
				grandmaNum1 = 0;
			}
			else if (lionNum1 > 0)
			{
				Warrior lion = new Warrior("Lion");
				for (int i = 0; i < lionNum1; i++)
					team1Unit3.add(lion);
				
				lionNum1 = 0;
			}
			else if (mortyNum1 > 0)
			{
				Warrior morty = new Warrior("Morty");
				for (int i = 0; i < mortyNum1; i++)
					team1Unit3.add(morty);
				
				mortyNum1 = 0;
			}
			else if (rickNum1 > 0)
			{
				Warrior rick = new Warrior("Rick");
				for (int i = 0; i < rickNum1; i++)
					team1Unit3.add(rick);
				
				rickNum1 = 0;
			}
			else if (spartanNum1 > 0)
			{
				Warrior spartan = new Warrior("Spartan");
				for (int i = 0; i < spartanNum1; i++)
					team1Unit3.add(spartan);
				
				spartanNum1 = 0;
			}
			else if (zombieNum1 > 0)
			{
				Warrior zombie = new Warrior("Zombie");
				for (int i = 0; i < zombieNum1; i++)
					team1Unit3.add(zombie);
				
				zombieNum1 = 0;
			}
			
		}
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
		// Team 2 ///////////////////////////////////////////////////////////////////////////////////////////////////
		// One unit
		if(numOfUnits2 == 1)
		{
			team2.add(team2Unit1);
			// Clear the unit just in case
			team2Unit1.clear();
			
			// Go through the warriorNums to find whatever doesnt have 0. 
			// Create the warrior that doesnt have 0.
			// Add it however many times to the first empty unit.
			
			// Add to unit 1
			if (grandmaNum2 > 0)
			{
				Warrior grandma = new Warrior("Grandma");
				for (int i = 0; i < grandmaNum2; i++)
					team2Unit1.add(grandma);
				
				grandmaNum2 = 0;
			}
			else if (lionNum2 > 0)
			{
				Warrior lion = new Warrior("Lion");
				for (int i = 0; i < lionNum2; i++)
					team2Unit1.add(lion);
				
				lionNum2 = 0;
			}
			else if (mortyNum2 > 0)
			{
				Warrior morty = new Warrior("Morty");
				for (int i = 0; i < mortyNum2; i++)
					team2Unit1.add(morty);
				
				mortyNum2 = 0;
			}
			else if (rickNum2 > 0)
			{
				Warrior rick = new Warrior("Rick");
				for (int i = 0; i < rickNum2; i++)
					team2Unit1.add(rick);
				
				rickNum2 = 0;
			}
			else if (spartanNum2 > 0)
			{
				Warrior spartan = new Warrior("Spartan");
				for (int i = 0; i < spartanNum2; i++)
					team2Unit1.add(spartan);
				
				spartanNum2 = 0;
			}
			else if (zombieNum2 > 0)
			{
				Warrior zombie = new Warrior("Zombie");
				for (int i = 0; i < zombieNum2; i++)
					team2Unit1.add(zombie);
				
				zombieNum2 = 0;
			}
		}
		
		// Two units
		else if(numOfUnits2 == 2)
		{
			team2.add(team2Unit1);
			team2.add(team2Unit2);
			// Clear the unit just in case
			team2Unit1.clear();
			team2Unit2.clear();
			
			// Add to unit 1
			if (grandmaNum2 > 0)
			{
				Warrior grandma = new Warrior("Grandma");
				for (int i = 0; i < grandmaNum2; i++)
					team2Unit1.add(grandma);
				
				grandmaNum2 = 0;
			}
			else if (lionNum2 > 0)
			{
				Warrior lion = new Warrior("Lion");
				for (int i = 0; i < lionNum2; i++)
					team2Unit1.add(lion);
				
				lionNum2 = 0;
			}
			else if (mortyNum2 > 0)
			{
				Warrior morty = new Warrior("Morty");
				for (int i = 0; i < mortyNum2; i++)
					team2Unit1.add(morty);
				
				mortyNum2 = 0;
			}
			else if (rickNum2 > 0)
			{
				Warrior rick = new Warrior("Rick");
				for (int i = 0; i < rickNum2; i++)
					team2Unit1.add(rick);
				
				rickNum2 = 0;
			}
			else if (spartanNum2 > 0)
			{
				Warrior spartan = new Warrior("Spartan");
				for (int i = 0; i < spartanNum2; i++)
					team2Unit1.add(spartan);
				
				spartanNum2 = 0;
			}
			else if (zombieNum2 > 0)
			{
				Warrior zombie = new Warrior("Zombie");
				for (int i = 0; i < zombieNum2; i++)
					team2Unit1.add(zombie);
				
				zombieNum2 = 0;
			}
			
			// Add to unit 2
			if (grandmaNum2 > 0)
			{
				Warrior grandma = new Warrior("Grandma");
				for (int i = 0; i < grandmaNum2; i++)
					team2Unit2.add(grandma);
				
				grandmaNum2 = 0;
			}
			else if (lionNum2 > 0)
			{
				Warrior lion = new Warrior("Lion");
				for (int i = 0; i < lionNum2; i++)
					team2Unit2.add(lion);
				
				lionNum2 = 0;
			}
			else if (mortyNum2 > 0)
			{
				Warrior morty = new Warrior("Morty");
				for (int i = 0; i < mortyNum2; i++)
					team2Unit2.add(morty);
				
				mortyNum2 = 0;
			}
			else if (rickNum2 > 0)
			{
				Warrior rick = new Warrior("Rick");
				for (int i = 0; i < rickNum2; i++)
					team2Unit2.add(rick);
				
				rickNum2 = 0;
			}
			else if (spartanNum2 > 0)
			{
				Warrior spartan = new Warrior("Spartan");
				for (int i = 0; i < spartanNum2; i++)
					team2Unit2.add(spartan);
				
				spartanNum2 = 0;
			}
			else if (zombieNum2 > 0)
			{
				Warrior zombie = new Warrior("Zombie");
				for (int i = 0; i < zombieNum2; i++)
					team2Unit2.add(zombie);
				
				zombieNum2 = 0;
			}
			
		}
		
		// Three units
		else if(numOfUnits2 == 3)
		{
			team2.add(team2Unit1);
			team2.add(team2Unit2);
			team2.add(team2Unit3);
			// Clear the unit just in case
			team2Unit1.clear();
			team2Unit2.clear();
			team2Unit3.clear();
			
			// Add to unit 1
			if (grandmaNum2 > 0)
			{
				Warrior grandma = new Warrior("Grandma");
				for (int i = 0; i < grandmaNum2; i++)
					team2Unit1.add(grandma);
				
				grandmaNum2 = 0;
			}
			else if (lionNum2 > 0)
			{
				Warrior lion = new Warrior("Lion");
				for (int i = 0; i < lionNum2; i++)
					team2Unit1.add(lion);
				
				lionNum2 = 0;
			}
			else if (mortyNum2 > 0)
			{
				Warrior morty = new Warrior("Morty");
				for (int i = 0; i < mortyNum2; i++)
					team2Unit1.add(morty);
				
				mortyNum2 = 0;
			}
			else if (rickNum2 > 0)
			{
				Warrior rick = new Warrior("Rick");
				for (int i = 0; i < rickNum2; i++)
					team2Unit1.add(rick);
				
				rickNum2 = 0;
			}
			else if (spartanNum2 > 0)
			{
				Warrior spartan = new Warrior("Spartan");
				for (int i = 0; i < spartanNum2; i++)
					team2Unit1.add(spartan);
				
				spartanNum2 = 0;
			}
			else if (zombieNum2 > 0)
			{
				Warrior zombie = new Warrior("Zombie");
				for (int i = 0; i < zombieNum2; i++)
					team2Unit1.add(zombie);
				
				zombieNum2 = 0;
			}
			
			// Add to unit 2
			if (grandmaNum2 > 0)
			{
				Warrior grandma = new Warrior("Grandma");
				for (int i = 0; i < grandmaNum2; i++)
					team2Unit2.add(grandma);
				
				grandmaNum2 = 0;
			}
			else if (lionNum2 > 0)
			{
				Warrior lion = new Warrior("Lion");
				for (int i = 0; i < lionNum2; i++)
					team2Unit2.add(lion);
				
				lionNum2 = 0;
			}
			else if (mortyNum2 > 0)
			{
				Warrior morty = new Warrior("Morty");
				for (int i = 0; i < mortyNum2; i++)
					team2Unit2.add(morty);
				
				mortyNum2 = 0;
			}
			else if (rickNum2 > 0)
			{
				Warrior rick = new Warrior("Rick");
				for (int i = 0; i < rickNum2; i++)
					team2Unit2.add(rick);
				
				rickNum2 = 0;
			}
			else if (spartanNum2 > 0)
			{
				Warrior spartan = new Warrior("Spartan");
				for (int i = 0; i < spartanNum2; i++)
					team2Unit2.add(spartan);
				
				spartanNum2 = 0;
			}
			else if (zombieNum2 > 0)
			{
				Warrior zombie = new Warrior("Zombie");
				for (int i = 0; i < zombieNum2; i++)
					team2Unit2.add(zombie);
				
				zombieNum2 = 0;
			}
			
			// Add to unit 3
			if (grandmaNum2 > 0)
			{
				Warrior grandma = new Warrior("Grandma");
				for (int i = 0; i < grandmaNum2; i++)
					team2Unit3.add(grandma);
				
				grandmaNum2 = 0;
			}
			else if (lionNum2 > 0)
			{
				Warrior lion = new Warrior("Lion");
				for (int i = 0; i < lionNum2; i++)
					team2Unit3.add(lion);
				
				lionNum2 = 0;
			}
			else if (mortyNum2 > 0)
			{
				Warrior morty = new Warrior("Morty");
				for (int i = 0; i < mortyNum2; i++)
					team2Unit3.add(morty);
				
				mortyNum2 = 0;
			}
			else if (rickNum2 > 0)
			{
				Warrior rick = new Warrior("Rick");
				for (int i = 0; i < rickNum2; i++)
					team2Unit3.add(rick);
				
				rickNum2 = 0;
			}
			else if (spartanNum2 > 0)
			{
				Warrior spartan = new Warrior("Spartan");
				for (int i = 0; i < spartanNum2; i++)
					team2Unit3.add(spartan);
				
				spartanNum2 = 0;
			}
			else if (zombieNum2 > 0)
			{
				Warrior zombie = new Warrior("Zombie");
				for (int i = 0; i < zombieNum2; i++)
					team2Unit3.add(zombie);
				
				zombieNum2 = 0;
			}
			
		}
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	}
	
	// See previously saved battles button
	public void seePrevious(ActionEvent e)
	{
		Object button = e.getSource();
		
		if (button == showPreviousBattles)
		{
			
		}
	}
	
	public void showSurvivors(ActionEvent e)
	{
		String button = e.getActionCommand();
		
		survivorsPanel.setLayout(new GridLayout(3, 1));
		survivorsPanel.setBackground(Color.white);
		southLeft.add(survivorsPanel);
		
		if(button.contentEquals("Show Survivors"))
		{
			if(winner.getText().equals("Team 1 Wins!")) 
			{
				for (int i = 0; i < team1.size(); i++)
				{
					JLabel s = new JLabel();
					s.setText(team1.get(i).toString());
					survivorsPanel.add(s);
				}
			}
			else
			{
				for (int i = 0; i < team2.size(); i++)
				{
					JLabel s = new JLabel();
					s.setText(team2.get(i).toString());
					survivorsPanel.add(s);
				}
			}

			southLeft.setBackground(Color.white);
			showSurvivors.setText("Hide Survivors");
			
		}
		else if(button.contentEquals("Hide Survivors"))
		{
			survivorsPanel.removeAll();
			survivorsPanel.revalidate();
			survivorsPanel.repaint();
			southLeft.remove(survivorsPanel);
			southLeft.setBackground(Color.darkGray);
			southLeft.repaint();
			showSurvivors.setText("Show Survivors");
		}
		System.out.println(team1);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
}
