/** My Account Screen */
public class MyAccountScreen extends Screen implements IDisplayComponent
{
    /** Display Components */
    private ArrayList<IDisplayComponent> components = new ArrayList<IDisplayComponent>() ;

    /** Front of Event Chain */
    private ITouchEventHandler chain ;

    private int startHeight;
    private int endHieght;

    public MyAccountScreen(int height) {
        startHeight = height;
    }

    /**
     * Display store screen
     */
    public void display() {
        
        int startingWidth = 10;
        int currentHeight = startHeight;

        background(255);
        textSize(14);
        fill(0, 0, 0, 255);

        String header = "My Account";
        text(header, (getWidth() - header.length() * 7) / 2, currentHeight);
        currentHeight += 20;

        strokeWeight(1);
        stroke(0, 0, 0);
        line(0, 40, 380, 40); 
        currentHeight += 40;

        text("Hi Admin!", startingWidth, currentHeight);
        currentHeight += 40;

        text("Add Card", startingWidth, currentHeight);
        currentHeight += 20;

        for (IDisplayComponent c: components) {
            c.display();
        }
    }

    /**
     * Set Next Touch Handler
     * @param next Touch Event Handler
     */
    public void setNext(ITouchEventHandler next) { }

    /**
     * Touch Event 
     * @param x Touch X
     * @param y Touch Y
     */
    public void touch(int x, int y) 
    {
        if (startHeight <= y && y <= endHieght) {
            // TODO: next() should jump to next screen
            next();
            System.out.println("Jump into " + "Add Card");
        } else if (chain != null) {
            chain.touch(x, y);
        }
    }

    /**
     * Add Display Component to Screen
     * @param c Display Component
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
}