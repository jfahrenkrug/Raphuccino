@import "RCElement.j"

@implementation RCRect : RCElement
{  
   int _cornerRadius @accessors(property=radius, readonly);
}

- (id)initWithRaphaelView:(RCRaphaelView)aRaphaelView rect:(CPRect)aRect
{
    return [self initWithRaphaelView:aRaphaelView rect:aRect cornerRadius:0];
}

- (id)initWithRaphaelView:(RCRaphaelView)aRaphaelView rect:(CPRect)aRect cornerRadius:(int)aRadius
{
    if (aRect === nil)
        [CPException raise:CPInvalidArgumentException reason:"Rect can't be nil."];
    
    if (self = [super initWithRaphaelView:aRaphaelView rect:aRect]) 
    {
       _cornerRadius = aRadius;
       _raphaelObject = [_raphaelView paper].rect(_rect.origin.x, _rect.origin.y, _rect.size.width, _rect.size.height, _cornerRadius);

       [self registerEvents];
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