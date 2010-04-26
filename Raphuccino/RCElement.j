@import <Foundation/CPObject.j>
@import "RCRaphaelView.j"

@implementation RCElement : CPObject
{  
    RCRaphaelView _raphaelView @accessors(property=raphaelView, readonly); 
    JSObject _raphaelObject @accessors(property=raphaelObject, readonly);
    // hold either just the origin coordinates, a rect, or the origin and the x and y radius of an ellipse
    CPRect _rect @accessors(property=rect, readonly); 
}

- (id)init
{
    return [self initWithRaphaelView:nil rect:nil allowEmptyRaphaelView:YES];
}

- (id)initWithRaphaelView:(RCRaphaelView)aRaphaelView
{
    return [self initWithRaphaelView:aRaphaelView rect:nil];
}

- (id)initWithRaphaelView:(RCRaphaelView)aRaphaelView rect:(CPRect)aRect
{
    return [self initWithRaphaelView:aRaphaelView rect:aRect allowEmptyRaphaelView:NO];
}

- (id)initWithRaphaelView:(RCRaphaelView)aRaphaelView rect:(CPRect)aRect allowEmptyRaphaelView:(BOOL)allowEmpty
{
    if ([self class] === [RCElement class])
        [CPException raise:CPInvalidArgumentException reason:"You can't directly instantiate RCElement, only subclasses thereof."];
    
    if (!allowEmpty && (aRaphaelView === nil || ![aRaphaelView isKindOfClass:[RCRaphaelView class]]))
        [CPException raise:CPInvalidArgumentException reason:"RaphaelView can't be nil and has to be an instance of RCRaphaelView."];
    
    if (self = [super init]) 
    {
        _rect = aRect;
        _raphaelView = aRaphaelView;
    }
    
    return self;
}


@end