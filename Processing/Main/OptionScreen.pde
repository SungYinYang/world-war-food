/** Option Screen which can choose custom option for item*/
public class OptionScreen extends Screen
{
    /** Display Components */
    private ArrayList<IDisplayComponent> components = new ArrayList<IDisplayComponent>() ;

    //use lower add component
    private ArrayList<Screen> comp = new ArrayList<Screen>() ;

    /** Front of Event Chain */
    private ITouchEventHandler chain ;

    //for price display
    private double totalPrice;

    //for Screen Title
    private String title;

    private int base; 

    public OptionScreen(String t)
    {
        totalPrice = 0;
        title = t;
//TODO 
        base = 90;
  OptionTitle title1 = new OptionTitle("Choose Cheese", "Cheese", base-15);
 // Screen item1 = new OptionItem("Danish Blue Cheese", 1, base);
//   Screen item2 = new OptionItem("Horsadish Cheddar", 1, base + 25*1);
//   Screen item3 = new OptionItem("Yello American", 1, base + 25*2);
//   OptionTitle title2 = new OptionTitle("Choose Topping", "Topping", base + 25*4);
//   Screen item4 = new OptionItem("Bermuda RedOnion", 0, base+ 25*5);
//   Screen item5 = new OptionItem("Black Onions", 0, base + 25*6);
//   Screen item6 = new OptionItem("Carrot Strings", 0, base + 25*7);
//   Screen item7 = new OptionItem("Coloslaw", 0, base + 25*8);
//   Screen item8 = new OptionItem("Jolepenos", 0, base + 25*9);
//   Screen item9 = new OptionItem("Sprouts", 0, base + 25*10);
//   OptionTitle title3 = new OptionTitle("Choose Sauce", "Sauce", base + 25*12);
//   Screen item10 = new OptionItem("Appricot Sauce", 0.75, base + 25*13);
//   Screen item11 = new OptionItem("Ranch", 0.75, base + 25*14);
//   Screen item12 = new OptionItem("Besil Pesto", 0.75, base + 25*15);
//   Screen basket = new Basket("View Basket", 630);
  addSubComp(title1);
//  addSubComp(item1);
//   addSubComp(item2);
//   addSubComp(item3);
//   addSubComp(title2);
//  addSubComp(item4);
//   addSubComp(item5);
//   addSubComp(item6);
//   addSubComp(item7);
//   addSubComp(item8);
//   addSubComp(item9);
//   addSubComp(title3);
//   addSubComp(item10);
//   addSubComp(item11);
//   addSubComp(item12);
//   addSubComp(basket);
  
    }

    /**
      * Display function
      * @return: currently useless
      */
    public void display(){

        int currentHeight = 20;
        background(255);
        textSize(20);
        fill(0, 0, 0, 255);

        text(title, (380 - title.length() * 7) / 2, currentHeight);
        currentHeight += 20;

        for (IDisplayComponent c: components) {
            c.display();
        }

        //price text
        textSize(16);
        fill(255);
        text("$"+totalPrice, 330, 660);
    }

    /**
     * Touch Event
     * @param x Touch X
     * @param y Touch Y
     */
    @Override
    public void touch(int x, int y) {
        chain.touch(x, y);

        //update price and update display price
        totalPrice = getSubTotal();
        //System.out.println(printDescription());  //testing code
    }

    /**
     * Add A Child Component
     * @param c Child Component
     */
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
     * Add A Child Component
     * @param c Child Component
     */
    public void addSubComp( Screen c )
    {
        addSubComponent((IDisplayComponent)c);         //add Display Component
        comp.add(c);        //add Screen Component for composite add/getSubtotal
    }


    /**
     * adding up total price
     * @return subtotal price
     */
    public double getSubTotal(){
        double subtotal = 0.0;
        for (Screen c: comp) {
            subtotal += c.add();
        }
        return subtotal;
    }

    /**
     * print description
     * @return a string that comprise all component information
     */
    public String printDescription(){
        StringBuilder description = new StringBuilder();
        for (Screen c: comp) {
            if(!c.title().equals("")){
                if(c.getClass().toString().split(" ", 2)[1].equals("Main$OptionTitle") ){
                    description.append("\n" + c.title() + ": ");
                }else
                    description.append(c.title() + ",");
            }
        }
        return description.toString();
    }

    //public void setFrame(){
    //  super.setFrame();
    //}
}