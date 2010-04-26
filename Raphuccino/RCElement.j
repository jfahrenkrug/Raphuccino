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


/*!
    The DOM node of this Raphael object
    @return the DOM node
*/
- (JSObject)node
{
    if (!_raphaelObject)
        return;
    
    return _raphaelObject.node;
}

/*!
    Remove this element from the DOM. The Element can't be used anymore after this method call!
*/
- (void)remove
{
    if (!_raphaelObject)
        return;
    
    _raphaelObject.remove();
}

/*!
    Makes this element invisible.
*/
- (void)hide
{
    if (!_raphaelObject)
        return;
    
    _raphaelObject.hide();
}

/*!
    Makes this element visible.
*/
- (void)show
{
    if (!_raphaelObject)
        return;
    
    _raphaelObject.show();
}

/*!
    Makes the element visible or invisible (calls show/hide).
*/
- (void)setVisible:(BOOL)visible
{
    if (visible)
        [self show];
    else
        [self hide];
}

/*!
    Rotates the element by the given degree from its center point, relative to the previous position.
    @param degrees the relative degrees
*/
- (void)rotate:(int)degrees
{
    [self rotate:degrees absolute:NO];
}

/*!
    Rotates the element by the given degree from its center point with an relative or absolute angle.
    @param degrees the degrees
    @param absolute relative or absolute angle?
*/
- (void)rotate:(int)degrees absolute:(BOOL)absolute
{
    if (!_raphaelObject)
        return;
    
    _raphaelObject.rotate(degrees, absolute);
}

/*!
    Rotates the element by the given degree around the given point
    @param point origin point of the rotation
    @param degrees the degrees
*/
- (void)rotateAroundPoint:(CPPoint)aPoint degrees:(int)degrees
{
    if (!_raphaelObject)
        return;
    
    _raphaelObject.rotate(degrees, aPoint.x, aPoint.y);
}


@end