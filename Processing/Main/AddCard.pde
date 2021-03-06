/**
* Add New Card Screen
*/
public class AddCard extends Screen implements IDisplayComponent
{
    /** Display Components */
	private ArrayList<IDisplayComponent> components = new ArrayList<IDisplayComponent>() ;
	/** Front of Event Chain */
	private ITouchEventHandler chain ;
	private KeyPad keypad = new KeyPad();
	private StringBuilder cardNumber = new StringBuilder("");
	private StringBuilder cardExpirty = new StringBuilder("");
	private StringBuilder cvv = new StringBuilder("");
	private boolean cardNumberFlag;
	private boolean cardExpirtyFlag;
	private boolean cardCVVFlag;
	private Map<String, String> cardInfo = new HashMap<String, String>();
	private ErrorScreen err;
  	private Header header;
  	private Button addPaymentButton;

	/**
	 * Constructor
	* Setting three flags for different focus
	*/
	public AddCard()
	{
		cardNumberFlag = true;
		cardExpirtyFlag = false;
		cardCVVFlag = false;
		err = new ErrorScreen("Incorrect Card Information!");
		header = new Header("Add Card");
		addPaymentButton = new Button("Save Payment Method");
		addSubComponent(header);
		addSubComponent(addPaymentButton);
	}

	/**
	 * Display
	* display the UI of addcard and the button
	*/
	public void display()
	{
		background(255,255,255);
		keypad.display();

		textAlign(LEFT);
		for (IDisplayComponent c: components) {
			textAlign(LEFT);
			textSize(25);
			text("Card Number", 10, 90); // Card Number text
			text(cardNumber.toString(), 30, 115); // Card Number
			line(30, 120, 350, 120); // Line under Card Number

			text("Expirty", 10, 150); // Card Expirty title
			text(cardExpirty.toString(), 30, 175); // Card Expirty
			line(30, 180, 150, 180); // Line under Card Expirty

			text("CVV", 200, 150); // Card CVV title
			text(cvv.toString(), 200, 175); // Card Expirty
			line(200, 180, 350, 180); // Line under Card Expirty
			c.display();
		}
	}


	/**
	 * Touch Event
	* @param x mouseX
	* @param y mouseY
	* touch different button will get different result
	* save cardInfo to local json file
	*/
	public void touch(int x, int y)
	{

		if(x > 10 && x < 130 && y > 60 && y < 110)
		{
			cardNumberFlag = true;
			cardExpirtyFlag = false;
			cardCVVFlag = false;
		}
		else if( x > 10 && x < 80 && y > 120 && y < 170)
		{
			cardNumberFlag = false;
			cardExpirtyFlag = true;
			cardCVVFlag = false;
		}
		else if( x > 120 && x < 300 && y > 120 && y < 170)
		{
			cardNumberFlag = false;
			cardExpirtyFlag = false;
			cardCVVFlag = true;
		}
		else if(cardNumberFlag && (cardNumber.length() < 16 || (y >= 530 && y <= 590 && x >= 265 && x <= 325)))
		{
			inputTouch(cardNumber, x, y, "cardNumber");
		}
		else if(cardExpirtyFlag && (cardExpirty.length() < 4 || (y >= 530 && y <= 590 && x >= 265 && x <= 325)))
		{
			inputTouch(cardExpirty, x, y, "cardExpirty");
		}
		else if(cardCVVFlag && (cvv.length() < 3 || (y >= 530 && y <= 590 && x >= 265 && x <= 325)))
		{
			inputTouch(cvv, x, y, "cvv");
		}
		else if (chain != null) {
			if(x > 0 && x < 380 && y > 620 && y < 680)
			{

				if(cardNumber.length() == 16 && cardExpirty.length() == 4 && cvv.length() == 3)
				{
					cardInfo.put("cardNumber", cardNumber.toString());
					cardInfo.put("cardExpirty", cardExpirty.toString());
					cardInfo.put("cardCVV", cvv.toString());
					addPaymentButton.setCardInfo(cardInfo);
				}
			}

		}
		chain.touch(x, y);


	}

	/**
	 * Next
	* go to next, Home screen
	*/
	public void next() {
		super.next();
	}

	// TODO: Fix Java Doc
	/**
	 * inputTouch
	* @param input, x, y, section. Taking input as stringbuilder for cardNumber, cardExpirty, CVV and section name
	* touch for add number to cardNumber, cardExpirty and CVV
	* go to next, Home screen
	*/
	public void inputTouch(StringBuilder input, int x, int y, String section)
	{
		if(x >= 55 && x <= 115)
		{
			if(y >= 230 && y <= 290)
			{
				println("1 pressed");
				input.append("1");
			}
			else if(y >= 330 && y <= 390)
			{
				input.append("4");
			}
			else if(y >= 430 && y <= 490)
			{
				input.append("7");
			}
		}
		else if(x >= 160 && x <= 220)
		{
			if(y >= 230 && y <= 290)
			{
				input.append("2");
			}
			else if(y >= 330 && y <= 390)
			{
				input.append("5");
			}
			else if(y >= 430 && y <= 490)
			{
				input.append("8");
			}
			else if(y >= 530 && y <= 590)
			{
				input.append("0");
			}
			}
			else if(x >= 265 && x <= 325)
			{

		if(y >= 230 && y <= 290)
		{
			input.append("3");
		}
		else if(y >= 330 && y <= 390)
		{
			input.append("6");
		}
		else if(y >= 430 && y <= 490)
		{
			input.append("9");
		}
		else if(y >= 530 && y <= 590)
		{
			if(section.equals("cardNumber") && cardNumber.length() > 0)
			{
				print("Delete by one \n");
				cardNumber.setLength(cardNumber.length() -1);
			}
			else if(section.equals("cardExpirty") && cardExpirty.length() > 0)
			{
				cardExpirty.setLength(cardExpirty.length() -1);
			}
			else if(section.equals("cvv") && cvv.length() > 0)
			{
				cvv.setLength(cvv.length() -1);
				}
			}
		}
	}

	/**
	 * Add Display Component to Screen
	* @param c Display Component
	*/
	@Override
	public void addSubComponent( IDisplayComponent c )
	{
		components.add( c ) ;
		if (components.size() == 1 )
		{
		chain = (ITouchEventHandler) c ;
		}
		else
		{
		ITouchEventHandler prev = (ITouchEventHandler) components.get(components.size()-2) ;
		prev.setNext( (ITouchEventHandler) c ) ;
		}
	}

	/**
	 * set the frame for MenuBar Screen
	 * @param f The frame reference
	 */
	public void setFrame(IFrame frame) {
		this.frame = frame;
		header.setFrame(frame);
		addPaymentButton.setFrame(frame);
	}
}
