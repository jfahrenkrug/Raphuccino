@import "RCElement.j"

@implementation RCCircle : RCElement
{  
   int _radius @accessors(property=radius, readonly);
}

- (id)initWithRaphaelView:(RCRaphaelView)aRaphaelView atPoint:(CPPoint)aPoint radius:(int)aRadius
{
    if (aPoint === nil)
        [CPException raise:CPInvalidArgumentException reason:"Point can't be nil."];
    
    if (self = [super initWithRaphaelView:aRaphaelView rect:CPMakeRect(aPoint.x, aPoint.y, 0, 0)]) 
    {
       _radius = aRadius;
       _raphaelObject = [_raphaelView paper].circle(aPoint.x, aPoint.y, _radius);
              
       [self registerEvents];
    }
    
    return self;
}

+ (RCCircle)circleWithRaphaelView:(RCRaphaelView)aRaphaelView atPoint:(CPPoint)aPoint radius:(int)aRadius
{
    return [[RCCircle alloc] initWithRaphaelView:aRaphaelView atPoint:aPoint radius:aRadius];
}

@end