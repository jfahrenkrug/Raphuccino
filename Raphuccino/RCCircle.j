/*
 * Raphuccino
 *
 * Copyright (c) 2010 Johannes Fahrenkrug (http://springenwerk.com)
 * Licensed under the MIT (http://www.opensource.org/licenses/mit-license.php) license.
 */

@import "RCElement.j"

/*! 
    @class RCCircle
    @brief A circle element.
*/
@implementation RCCircle : RCElement
{  
   int _radius @accessors(property=radius, readonly);
}

/*!
    Initialize the circle at the given point
    @param raphaelView the raphaelView that should contain this circle
    @param point the center point
    @param radius the radius
*/
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

/*!
    Create a new circle at the given point
    @param raphaelView the raphaelView that should contain this circle
    @param point the center point
    @param radius the radius
*/
+ (RCCircle)circleWithRaphaelView:(RCRaphaelView)aRaphaelView atPoint:(CPPoint)aPoint radius:(int)aRadius
{
    return [[RCCircle alloc] initWithRaphaelView:aRaphaelView atPoint:aPoint radius:aRadius];
}

@end