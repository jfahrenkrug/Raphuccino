@import <Foundation/CPObject.j>
@import "RCRaphaelView.j"

@implementation RCElement : CPObject
{  
    RCRaphaelView _raphaelView @accessors(property=raphaelView, readonly); 
    JSObject _raphaelObject @accessors(property=raphaelObject, readonly);
    CPPoint _point @accessors(property=point, readonly); 
}

- (id)initWithRaphaelView:(RCRaphaelView)aRaphaelView atPoint:(CPPoint)aPoint
{
    if ([self class] === [RCElement class])
        [CPException raise:CPInvalidArgumentException reason:"You can't directly instantiate RCElement, only subclasses thereof."];
    
    if (aRaphaelView === nil || ![aRaphaelView isKindOfClass:[RCRaphaelView class]])
        [CPException raise:CPInvalidArgumentException reason:"RaphaelView can't be nil and has to be an instance of RCRaphaelView."];
        
    if (aPoint === nil)
        [CPException raise:CPInvalidArgumentException reason:"Point can't be nil."];

    
    if (self = [super init]) 
    {
        _point = aPoint;
        _raphaelView = aRaphaelView;
    }
    
    return self;
}

- (void)addToView:(RCRaphaelView)aView
{
    if (_raphaelView === nil)
    {
        _raphaelView = aView;
        //todo: make sure aView is kind of RCRaphaelView
        _raphaelView.addElement(self);
    } 
    else
    {
        //error: already added
    }
}

@end