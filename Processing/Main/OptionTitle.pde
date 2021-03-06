/** Payments Screen */
public class OptionTitle extends Screen implements IDisplayComponent, ITouchEventHandler
{    
    private ITouchEventHandler nextHandler ;

    private String name;
    private String type;
    private int curHeight;

    public OptionTitle(String n, String t, int height)
    {
        name = n;
        type = t;
        curHeight = height;
    }

    /**
      * Display function
      * @return: currently useless
      */
    public void display(){
        //All Txt
        textSize(14);
        fill(0);
        text(name, 20, curHeight);
    }

    /**
     * Set Next Touch Handler
     * @param next Touch Event Handler
     */
    public void setNext(ITouchEventHandler next)
    {
        nextHandler = next ;
    }

    /**
     * Touch Event
     * @param x Touch X
     * @param y Touch Y
     */
    public void touch(int x, int y){
        //not a touch bottom thus do nothing
        if (nextHandler != null) {
            nextHandler.touch(x,y);
        }
    }

    /**
     * return the name to print
     */
    public String title(){
        return type;
    }

    // TODO: delele later
    public double getPrice(){
        System.out.println("in optionItem");
        return 0.0;
    }
}
