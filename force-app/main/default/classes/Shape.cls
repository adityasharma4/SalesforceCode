public virtual class Shape {
    public String name { get; protected set; }

    public Shape() {

    }

    public virtual void calculateArea() {
        system.debug('The area of a shape');
    }

    public void normalMethod() {
        
    }
}
