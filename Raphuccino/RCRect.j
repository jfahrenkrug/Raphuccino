@import "RCElement.j"

@implementation RCRect : RCElement
{  
   int _cornerRadius @accessors(property=radius, readonly);
   CPSize _size @accessors(property=size, readonly);
}

- (id)initWithRaphaelView:(RCRaphaelView)aRaphaelView rect:(CPRect)aRect
{
    return [self initWithRaphaelView:aRaphaelView rect:aRect cornerRadius:0];
}

- (id)initWithRaphaelView:(RCRaphaelView)aRaphaelView rect:(CPRect)aRect cornerRadius:(int)aRadius
{
    if (self = [super initWithRaphaelView:aRaphaelView atPoint:CPMakePoint(aRect.origin.x, aRect.origin.y)]) 
    {
       _cornerRadius = aRadius;
       _size = CPMakeSize(aRect.size.width, aRect.size.height);
       _raphaelObject = [_raphaelView paper].rect(_point.x, _point.y, _size.width, _size.height, _cornerRadius);

       // Sets the fill attribute of the circle to red (#f00)
       //_raphaelObject.attr("fill", "#f00");

       // Sets the stroke attribute of the circle to white
       //_raphaelObject.attr("stroke", "#fff");
    }
    
    return self;
}

+ (RCRect)rectWithRaphaelView:(RCRaphaelView)aRaphaelView rect:(CPRect)aRect
{
    return [[RCRect alloc] initWithRaphaelView:aRaphaelView rect:aRect];
}

+ (RCRect)rectWithRaphaelView:(RCRaphaelView)aRaphaelView rect:(CPRect)aRect cornerRadius:(int)aRadius
{
    return [[RCRect alloc] initWithRaphaelView:aRaphaelView rect:aRect cornerRadius:aRadius];
}

@end