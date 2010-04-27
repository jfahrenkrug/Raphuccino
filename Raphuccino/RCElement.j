/*
 * Raphuccino
 *
 * Copyright (c) 2010 Johannes Fahrenkrug (http://springenwerk.com)
 * Licensed under the MIT (http://www.opensource.org/licenses/mit-license.php) license.
 */

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

/*! 
    @class RCElement
    @brief The abstract base class for all the elements.
*/
@implementation RCElement : CPObject
{  
    RCRaphaelView _raphaelView @accessors(property=raphaelView, readonly); 
    JSObject _raphaelObject @accessors(property=raphaelObject, readonly);
    // hold either just the origin coordinates, a rect, or the origin and the x and y radius of an ellipse
    CPRect _rect @accessors(property=rect, readonly); 
    id _delegate @accessors(property=delegate);
}

/*!
    Initialize the element without a raphaelView (needed for RCSet)
*/
- (id)init
{
    return [self initWithRaphaelView:nil rect:nil allowEmptyRaphaelView:YES];
}

/*!
    Initialize the element with a raphaelView but without a size
    @param raphaelView the raphaelView that should contain this element
*/
- (id)initWithRaphaelView:(RCRaphaelView)aRaphaelView
{
    return [self initWithRaphaelView:aRaphaelView rect:nil];
}

/*!
    Initialize the element with a raphaelView and a size
    @param raphaelView the raphaelView that should contain this element
    @param rect either a rect or a start point and the x and y radius of an ellipse
*/
- (id)initWithRaphaelView:(RCRaphaelView)aRaphaelView rect:(CPRect)aRect
{
    return [self initWithRaphaelView:aRaphaelView rect:aRect allowEmptyRaphaelView:NO];
}

/*!
    Designated initializer: Initialize the element with a raphaelView and a size
    @param raphaelView the raphaelView that should contain this element
    @param rect either a rect or a start point and the x and y radius of an ellipse
    @param allowEmptyRaphaelView allow the raphaelView to be nil
*/
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
    Sets up all the events to call delegate methods
*/
- (void)registerEvents
{
    if (!_raphaelObject)
        return;
        
    _raphaelObject.click(function (event) {
        if (_delegate && [_delegate respondsToSelector:@selector(raphaelElementWasClicked:)]) 
        {
            [_delegate raphaelElementWasClicked:self];
        }
    });
    _raphaelObject.dblclick(function (event) {
        if (_delegate && [_delegate respondsToSelector:@selector(raphaelElementWasDoubleClicked:)]) 
        {
            [_delegate raphaelElementWasDoubleClicked:self];
        }
    });
    _raphaelObject.mousedown(function (event) {
        if (_delegate && [_delegate respondsToSelector:@selector(raphaelElementMouseDown:atPoint:)]) 
        {
            [_delegate raphaelElementMouseDown:self atPoint:CPMakePoint(event.x, event.y)];
        }
    });
    _raphaelObject.mousemove(function (event) {
        if (_delegate && [_delegate respondsToSelector:@selector(raphaelElementMouseDidMove:toPoint:)]) 
        {
            [_delegate raphaelElementMouseDidMove:self toPoint:CPMakePoint(event.x, event.y)];
        }
    });
    _raphaelObject.mouseout(function (event) {
        if (_delegate && [_delegate respondsToSelector:@selector(raphaelElementMouseOut:)]) 
        {
            [_delegate raphaelElementMouseOut:self];
        }
    });
    _raphaelObject.mouseover(function (event) {
        if (_delegate && [_delegate respondsToSelector:@selector(raphaelElementMouseOver:)]) 
        {
            [_delegate raphaelElementMouseOver:self];
        }
    });
    _raphaelObject.mouseup(function (event) {
        if (_delegate && [_delegate respondsToSelector:@selector(raphaelElementMouseUp:atPoint:)]) 
        {
            [_delegate raphaelElementMouseUp:self atPoint:CPMakePoint(event.x, event.y)];
        }
    });
    _raphaelObject.hover(function (event) {
        if (_delegate && [_delegate respondsToSelector:@selector(raphaelElementDidBeginHover:)]) 
        {
            [_delegate raphaelElementDidBeginHover:self];
        }
    }, function (event) {
        if (_delegate && [_delegate respondsToSelector:@selector(raphaelElementDidEndHover:)]) 
        {
            [_delegate raphaelElementDidEndHover:self];
        }
    });
}

/*!
    Sets the functions that should be called on hover start and end events
    @param startFunction JS function when mouse enters element
    @param endFunction JS function when mouse leaves element
*/
- (void)setHoverStartFunction:(JSObject)startFunction endFunction:(JSObject)endFunction
{
    if (!_raphaelObject)
        return;
        
    _raphaelObject.hover(startFunction, endFunction);
}

/*!
    Sets the functions that should be called when the element is clicked
    @param aFunction JS function
*/
- (void)setClickFunction:(JSObject)aFunction
{
    if (!_raphaelObject)
        return;
        
    _raphaelObject.click(aFunction);
}

/*!
    Sets the functions that should be called when the element is double clicked
    @param aFunction JS function
*/
- (void)setDoubleClickFunction:(JSObject)aFunction
{
    if (!_raphaelObject)
        return;
        
    _raphaelObject.dblclick(aFunction);
}

/*!
    Sets the functions that should be called when the element receives the mouse down event
    @param aFunction JS function
*/
- (void)setMouseDownFunction:(JSObject)aFunction
{
    if (!_raphaelObject)
        return;
        
    _raphaelObject.mousedown(aFunction);
}

/*!
    Sets the functions that should be called when the element receives the mouse up event
    @param aFunction JS function
*/
- (void)setMouseUpFunction:(JSObject)aFunction
{
    if (!_raphaelObject)
        return;
        
    _raphaelObject.mouseup(aFunction);
}

/*!
    Sets the functions that should be called when the element receives the mouse move event
    @param aFunction JS function
*/
- (void)setMouseMoveFunction:(JSObject)aFunction
{
    if (!_raphaelObject)
        return;
        
    _raphaelObject.mousemove(aFunction);
}

/*!
    Sets the functions that should be called when the element receives the mouse out event
    @param aFunction JS function
*/
- (void)setMouseOutFunction:(JSObject)aFunction
{
    if (!_raphaelObject)
        return;
        
    _raphaelObject.mouseout(aFunction);
}

/*!
    Sets the functions that should be called when the element receives the mouse over event
    @param aFunction JS function
*/
- (void)setMouseOverFunction:(JSObject)aFunction
{
    if (!_raphaelObject)
        return;
        
    _raphaelObject.mouseover(aFunction);
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

/*!
    Animates the current values of the attributes to the given new values. It calls a delegate method when the animation is finished.
    @param duration duration of the animation in milliseconds
    @param newAttributes an associative js array of target attributes 
*/
- (void)animateWithDuration:(int)milliseconds toNewAttributes:(JSObject)newAttributes
{
    [self animateWithDuration:milliseconds toNewAttributes:newAttributes animationCurve:RCAnimationLinear callbackFunction:nil];
}

/*!
    Animates the current values of the attributes to the given new values. It does not call a delegate method but the given callback function.
    @param duration duration of the animation in milliseconds
    @param newAttributes an associative js array of target attributes 
    @param callbackFunction function to call when animation is finished
*/
- (void)animateWithDuration:(int)milliseconds toNewAttributes:(JSObject)newAttributes callbackFunction:(JSObject)aCallbackFunction
{
    [self animateWithDuration:milliseconds toNewAttributes:newAttributes animationCurve:RCAnimationLinear callbackFunction:aCallbackFunction];
}

/*!
    Animates the current values of the attributes to the given new values. It calls a delegate method when the animation is finished.
    @param duration duration of the animation in milliseconds
    @param newAttributes an associative js array of target attributes 
    @param animationCurve the timing curve of the animation (ease in, out etc)
*/
- (void)animateWithDuration:(int)milliseconds toNewAttributes:(JSObject)newAttributes animationCurve:(CPString)animationCurve
{
    [self animateWithDuration:milliseconds toNewAttributes:newAttributes animationCurve:animationCurve callbackFunction:nil];
}

/*!
    Animates the current values of the attributes to the given new values. It only calls a delegate method if the given callback function is nil.
    @param duration duration of the animation in milliseconds
    @param newAttributes an associative js array of target attributes 
    @param animationCurve the timing curve of the animation (ease in, out etc)
    @param callbackFunction function to call when animation is finished
*/
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

/*!
    Animates the the element along a given SVG path. It calls a delegate method when the animation is finished.
    @param path can be a string, an instance of RCPath or a raphael JS path object
    @param duration duration of the animation in milliseconds
*/
- (void)animateAlongPath:(id)aPathElementOrString duration:(int)milliseconds
{
    [self animateAlongPath:aPathElementOrString duration:milliseconds rotate:NO callbackFunction:nil];
}

/*!
    Animates the the element along a given SVG path. It calls a delegate method when the animation is finished.
    @param path can be a string, an instance of RCPath or a raphael JS path object
    @param duration duration of the animation in milliseconds
    @param rotate indicates whether the object should be rotated along the path
*/
- (void)animateAlongPath:(id)aPathElementOrString duration:(int)milliseconds rotate:(BOOL)shouldRotate
{
    [self animateAlongPath:aPathElementOrString duration:milliseconds rotate:shouldRotate callbackFunction:nil];
}

/*!
    Animates the the element along a given SVG path. It only calls a delegate method if the given callback function is nil.
    @param path can be a string, an instance of RCPath or a raphael JS path object
    @param duration duration of the animation in milliseconds
    @param callbackFunction function to call when animation is finished
*/
- (void)animateAlongPath:(id)aPathElementOrString duration:(int)milliseconds callbackFunction:(JSObject)aCallbackFunction
{
    [self animateAlongPath:aPathElementOrString duration:milliseconds rotate:NO callbackFunction:aCallbackFunction];
}

/*!
    Animates the the element along a given SVG path. It only calls a delegate method if the given callback function is nil.
    @param path can be a string, an instance of RCPath or a raphael JS path object
    @param duration duration of the animation in milliseconds
    @param rotate indicates whether the object should be rotated along the path
    @param callbackFunction function to call when animation is finished
*/
- (void)animateAlongPath:(id)aPathElementOrString duration:(int)milliseconds rotate:(BOOL)shouldRotate callbackFunction:(JSObject)aCallbackFunction
{
    [self animateAlongPath:aPathElementOrString duration:milliseconds rotate:shouldRotate reverse:NO callbackFunction:aCallbackFunction];
}

/*!
    Animates the the element along a given SVG path. It only calls a delegate method if the given callback function is nil.
    @param path can be a string, an instance of RCPath or a raphael JS path object
    @param duration duration of the animation in milliseconds
    @param rotate indicates whether the object should be rotated along the path
    @param reverse go in the opposite direction
    @param callbackFunction function to call when animation is finished
*/
- (void)animateAlongPath:(id)aPathElementOrString duration:(int)milliseconds rotate:(BOOL)shouldRotate reverse:(BOOL)shouldGoReverse callbackFunction:(JSObject)aCallbackFunction
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
    
    try 
    {
        if ([aPathElementOrString isKindOfClass:[RCPath class]])
        {
            aPathElementOrString = [aPathElementOrString raphaelObject];
        }
    }
    catch(e) 
    {
    }
        
    if (shouldGoReverse)
        _raphaelObject.animateAlongBack(aPathElementOrString, milliseconds, shouldRotate, aCallbackFunction);
    else 
        _raphaelObject.animateAlong(aPathElementOrString, milliseconds, shouldRotate, aCallbackFunction);
}

/*!
    The function that gets called on every step of an animation
    @return a JS function
*/
- (JSObject)onAnimationFunction
{
    if (!_raphaelObject)
        return;
        
    return _raphaelObject.onAnimation;
}

/*!
    Sets the function that should be called on every step of an animation
    @param function a JS function
*/
- (void)setOnAnimationFunction:(JSObject)aFunction
{
    if (!_raphaelObject)
        return;
        
    return _raphaelObject.onAnimation(aFunction);
}

/*!
    The bounding box of the element
    @return a CPRect that defines the bounding box
*/
- (CPRect)bounds
{
    if (!_raphaelObject)
        return CPMakeRect(0, 0, 0, 0);
     
    var bb = _raphaelObject.getBBox()
    console.log(bb);   
    return CPMakeRect(bb.x, bb.y, bb.width, bb.height);
}

/*!
    moves the element to the front (z axis)
*/
- (void)moveToFront
{
    if (!_raphaelObject)
        return;
    
    _raphaelObject.toFront();
}

/*!
    moves the element to the back (z axis)
*/
- (void)moveToBack
{
    if (!_raphaelObject)
        return;
    
    _raphaelObject.toBack();
}

/*!
    insert this element before the given one
    @param element element which the current element should be inserted in front of
*/
- (void)insertBefore:(RCElement)anElement
{
    if (!_raphaelObject)
        return;
    
    _raphaelObject.insertBefore([anElement raphaelObject]);
}

/*!
    insert this element after the given one
    @param element element after which the current element should be inserted
*/
- (void)insertAfter:(RCElement)anElement
{
    if (!_raphaelObject)
        return;
    
    _raphaelObject.insertAfter([anElement raphaelObject]);
}



//TODO: implement animateWith




@end