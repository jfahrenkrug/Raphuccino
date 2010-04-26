@import <Foundation/CPObject.j>
@import "RCRaphaelView.j"

/*
    @global
    @group RCAnimationCurve
*/
RCAnimationEaseInOut    = @"<>";
/*
    @global
    @group RCAnimationCurve
*/
RCAnimationEaseIn       = @"<";
/*
    @global
    @group RCAnimationCurve
*/
RCAnimationEaseOut      = @">";
/*
    @global
    @group RCAnimationCurve
*/
RCAnimationBackIn      = @"backIn";
/*
    @global
    @group RCAnimationCurve
*/
RCAnimationBackOut      = @"backOut";
/*
    @global
    @group RCAnimationCurve
*/
RCAnimationBounce      = @"bounce";
/*
    @global
    @group RCAnimationCurve
*/
RCAnimationElastic      = @"elastic";
/*
    @global
    @group RCAnimationCurve
*/
RCAnimationLinear       = nil;

@implementation RCElement : CPObject
{  
    RCRaphaelView _raphaelView @accessors(property=raphaelView, readonly); 
    JSObject _raphaelObject @accessors(property=raphaelObject, readonly);
    // hold either just the origin coordinates, a rect, or the origin and the x and y radius of an ellipse
    CPRect _rect @accessors(property=rect, readonly); 
    id _delegate @accessors(property=delegate);
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

/*!
    Moves the element around the canvas by the given distances.
    @param x distance on the x axis
    @param y distance on the y axis
*/
- (void)translateByX:(int)x y:(int)y
{
    if (!_raphaelObject)
        return;
    
    _raphaelObject.translate(x, y);
}

/*!
    Resizes the element by the given multiplier.
    @param x Amount to scale horizontally
    @param y Amount to scale vertically
*/
- (void)scaleByX:(float)x y:(float)y
{
    if (!_raphaelObject)
        return;
    
    _raphaelObject.scale(x, y);
}

/*!
    Resizes the element by the given multiplier with the given point as the origin.
    @param x Amount to scale horizontally
    @param y Amount to scale vertically
    @param origin center of scaling
*/
- (void)scaleByX:(float)x y:(float)y origin:(CPPoint)aPoint
{
    if (!_raphaelObject)
        return;
    
    _raphaelObject.scale(x, y, aPoint.x, aPoint.y);
}

/*!
    The attributes of the this element
    @return hash of the attributes
*/
- (JSObject)attr
{
    if (!_raphaelObject)
        return;
    
    return _raphaelObject.attr();
}

/*!
    Sets the attributes
    Please see http://raphaeljs.com/reference.html#attr
    @param attributes an associative js array of attributes
*/
- (void)setAttr:(JSObject)someAttributes
{
    if (!_raphaelObject)
        return;
    
    _raphaelObject.attr(someAttributes);
}

- (void)animateWithDuration:(int)milliseconds toNewAttributes:(JSObject)newAttributes
{
    [self animateWithDuration:milliseconds toNewAttributes:newAttributes animationCurve:RCAnimationLinear callbackFunction:nil];
}

- (void)animateWithDuration:(int)milliseconds toNewAttributes:(JSObject)newAttributes callbackFunction:(JSObject)aCallbackFunction
{
    [self animateWithDuration:milliseconds toNewAttributes:newAttributes animationCurve:RCAnimationLinear callbackFunction:aCallbackFunction];
}

- (void)animateWithDuration:(int)milliseconds toNewAttributes:(JSObject)newAttributes animationCurve:(CPString)animationCurve
{
    [self animateWithDuration:milliseconds toNewAttributes:newAttributes animationCurve:animationCurve callbackFunction:nil];
}

- (void)animateWithDuration:(int)milliseconds toNewAttributes:(JSObject)newAttributes animationCurve:(CPString)animationCurve callbackFunction:(JSObject)aCallbackFunction
{
    if (!_raphaelObject)
        return;
        
    if (!aCallbackFunction)
    {
        aCallbackFunction = function() 
        {
            if (_delegate && [_delegate respondsToSelector:@selector(raphaelElementDidFinishAnimating:)]) 
            {
                [_delegate raphaelElementDidFinishAnimating:self];
            }
        };
    }
    
    if (!animationCurve)
    {
        _raphaelObject.animate(newAttributes, milliseconds, aCallbackFunction);
    }
    else
    {
        _raphaelObject.animate(newAttributes, milliseconds, animationCurve, aCallbackFunction);
    }
}


@end