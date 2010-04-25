@import "RCElement.j"

@implementation RCCircle : RCElement
{  
   int _radius @accessors(property=radius, readonly);
}

- (id)initWithRaphaelView:(RCRaphaelView)aRaphaelView atPoint:(CPPoint)aPoint radius:(int)aRadius
{
    if (self = [super initWithRaphaelView:aRaphaelView atPoint:aPoint]) 
    {
       _radius = aRadius;
       _raphaelObject = [_raphaelView paper].circle(_point.x, _point.y, _radius);
              
       // Sets the fill attribute of the circle to red (#f00)
       //_raphaelObject.attr("fill", "#f00");

       // Sets the stroke attribute of the circle to white
       //_raphaelObject.attr("stroke", "#fff");
    }
    
    return self;
}

+ (RCCircle)circleWithRaphaelView:(RCRaphaelView)aRaphaelView atPoint:(CPPoint)aPoint radius:(int)aRadius
{
    return [[RCCircle alloc] initWithRaphaelView:aRaphaelView atPoint:aPoint radius:aRadius];
}

@end