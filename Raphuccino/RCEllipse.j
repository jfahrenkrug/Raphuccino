@import "RCElement.j"

@implementation RCEllipse : RCElement
{  
}

- (id)initWithRaphaelView:(RCRaphaelView)aRaphaelView atPoint:(CPPoint)aPoint xRadius:(int)anXRadius yRadius:(int)aYRadius
{
    if (aPoint === nil)
        [CPException raise:CPInvalidArgumentException reason:"Point can't be nil."];
    
    return [self initWithRaphaelView:aRaphaelView rect:CPMakeRect(aPoint.x, aPoint.y, anXRadius, aYRadius)];
}

- (id)initWithRaphaelView:(RCRaphaelView)aRaphaelView rect:(CPRect)aRect
{
    if (aRect === nil)
        [CPException raise:CPInvalidArgumentException reason:"Rect can't be nil."];
    
    if (self = [super initWithRaphaelView:aRaphaelView rect:aRect]) 
    {
       _raphaelObject = [_raphaelView paper].ellipse(_rect.origin.x, _rect.origin.y, _rect.size.width, _rect.size.height);

       // Sets the fill attribute of the circle to red (#f00)
       //_raphaelObject.attr("fill", "#f00");

       // Sets the stroke attribute of the circle to white
       //_raphaelObject.attr("stroke", "#fff");
    }
    
    return self;
}

+ (RCEllipse)ellipseWithRaphaelView:(RCRaphaelView)aRaphaelView rect:(CPRect)aRect
{
    return [[RCEllipse alloc] initWithRaphaelView:aRaphaelView rect:aRect];
}

+ (RCEllipse)ellipseWithRaphaelView:(RCRaphaelView)aRaphaelView atPoint:(CPPoint)aPoint xRadius:(int)anXRadius yRadius:(int)aYRadius
{
    return [[RCEllipse alloc] initWithRaphaelView:aRaphaelView atPoint:aPoint xRadius:anXRadius yRadius:aYRadius];
}

@end