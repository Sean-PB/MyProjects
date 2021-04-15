package TicTacToe;
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;

public class TicTacToeFrame extends JFrame implements ActionListener{

	private static final int WIDTH = 500;
	private static final int HEIGHT = 400;
	
	int count = 0;
	boolean end = false;


	JButton button1 = new JButton();
	JButton button2 = new JButton();
	JButton button3 = new JButton();
	JButton button4 = new JButton();
	JButton button5 = new JButton();
	JButton button6 = new JButton();
	JButton button7 = new JButton();
	JButton button8 = new JButton();
	JButton button9 = new JButton();

	// GUI
	public TicTacToeFrame()
	{
		// Window
		super("TicTacToe!");
		setSize(WIDTH, HEIGHT);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setLayout(new BorderLayout());
		
		// Button area
		JPanel button = new JPanel();
		button.setBackground(Color.BLUE);
		button.setLayout(new GridLayout(3, 3));
		add(button, java.awt.BorderLayout.CENTER);
		
		// Buttons
		// 1
		button1.addActionListener(this);
		button1.setText("");
		button.add(button1);
		// 2
		button2.addActionListener(this);
		button2.setText("");
		button.add(button2);
		// 3
		button3.addActionListener(this);
		button3.setText("");
		button.add(button3);
		// 4
		button4.addActionListener(this);
		button4.setText("");
		button.add(button4);
		// 5
		button5.addActionListener(this);
		button5.setText("");
		button.add(button5);
		// 6
		button6.addActionListener(this);
		button6.setText("");
		button.add(button6);
		// 7
		button7.addActionListener(this);
		button7.setText("");
		button.add(button7);
		// 8
		button8.addActionListener(this);
		button8.setText("");
		button.add(button8);
		// 9
		button9.addActionListener(this);
		button9.setText("");
		button.add(button9);
	}

	// Winner display
	public JPanel showWinner(String whoWon)
	{
		JPanel winnerArea = new JPanel();
		if(whoWon.contentEquals("X"))
		{
			winnerArea.setBackground(Color.red);
		}
		else
			winnerArea.setBackground(Color.yellow);

		
		add(winnerArea, java.awt.BorderLayout.NORTH);
		JLabel winner = new JLabel(whoWon);
		winner.setBackground(Color.YELLOW);
		winnerArea.add(winner);
		return winnerArea;
	}

	public void actionPerformed(ActionEvent e)
	{
		JButton buttonClicked = (JButton) e.getSource();
		
		if(count%2 == 0 && buttonClicked.getText() == "")
		{
			buttonClicked.setText("X");
			buttonClicked.setBackground(Color.red);
			count++;
		}
		else if(count%2 == 1 && buttonClicked.getText() == "")
		{
			buttonClicked.setText("O");
			buttonClicked.setBackground(Color.yellow);
			count++;
		}
		
		if( (button1.getText() == button2.getText() && button2.getText() == button3.getText() && (button3.getText().contentEquals("X") || button3.getText().contentEquals("O")))
				|| (button1.getText() == button4.getText() && button4.getText() == button7.getText() && (button7.getText().contentEquals("X") || button7.getText().contentEquals("O")))
				|| (button1.getText() == button5.getText() && button5.getText() == button9.getText() && (button9.getText().contentEquals("X") || button9.getText().contentEquals("O")))
				|| (button7.getText() == button8.getText() && button8.getText() == button9.getText() && (button9.getText().contentEquals("X") || button9.getText().contentEquals("O")))
				|| (button9.getText() == button6.getText() && button6.getText() == button3.getText() && (button3.getText().contentEquals("X") || button3.getText().contentEquals("O")))
				|| (button7.getText() == button5.getText() && button5.getText() == button3.getText() && (button3.getText().contentEquals("X") || button3.getText().contentEquals("O")))
				|| (button2.getText() == button5.getText() && button5.getText() == button8.getText() && (button8.getText().contentEquals("X") || button8.getText().contentEquals("O")))
				|| (button4.getText() == button5.getText() && button5.getText() == button6.getText() && (button6.getText().contentEquals("X") || button6.getText().contentEquals("O"))) )
		{
				add(showWinner("Player " + buttonClicked.getText() + " won!"), java.awt.BorderLayout.NORTH);
		}
		else if( (button1.getText().contentEquals("X") || button1.getText().contentEquals("O"))
				&& (button2.getText().contentEquals("X") || button2.getText().contentEquals("O")) 
				&& (button3.getText().contentEquals("X") || button3.getText().contentEquals("O")) 
				&& (button4.getText().contentEquals("X") || button4.getText().contentEquals("O")) 
				&& (button5.getText().contentEquals("X") || button5.getText().contentEquals("O")) 
				&& (button6.getText().contentEquals("X") || button6.getText().contentEquals("O")) 
				&& (button7.getText().contentEquals("X") || button7.getText().contentEquals("O")) 
				&& (button8.getText().contentEquals("X") || button8.getText().contentEquals("O")) 
				&& (button9.getText().contentEquals("X") || button9.getText().contentEquals("O")) )
		{
			add(showWinner("Cats Game!"), java.awt.BorderLayout.NORTH);
		}
		
	}


}