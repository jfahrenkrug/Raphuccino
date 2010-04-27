/*
 * Raphuccino
 *
 * Copyright (c) 2010 Johannes Fahrenkrug (http://springenwerk.com)
 * Licensed under the MIT (http://www.opensource.org/licenses/mit-license.php) license.
 */

@import "RCElement.j"

/*! 
    @class RCEllipse
    @brief An ellipse element.
*/
@implementation RCEllipse : RCElement
{  
}

/*!
    Initialize the ellipse at the given point
    @param raphaelView the raphaelView that should contain this ellipse
    @param point the center point
    @param xRadius the radius of the x axis
    @param yRadius the radius of the y axis
*/
- (id)initWithRaphaelView:(RCRaphaelView)aRaphaelView atPoint:(CPPoint)aPoint xRadius:(int)anXRadius yRadius:(int)aYRadius
{
    if (aPoint === nil)
        [CPException raise:CPInvalidArgumentException reason:"Point can't be nil."];
    
    return [self initWithRaphaelView:aRaphaelView rect:CPMakeRect(aPoint.x, aPoint.y, anXRadius, aYRadius)];
}

/*!
    Designated initializer: Initialize the ellipse at the given point
    @param raphaelView the raphaelView that should contain this ellipse
    @param rect contains the center point and the radius of the x and y axis
*/
- (id)initWithRaphaelView:(RCRaphaelView)aRaphaelView rect:(CPRect)aRect
{
    if (aRect === nil)
        [CPException raise:CPInvalidArgumentException reason:"Rect can't be nil."];
    
    if (self = [super initWithRaphaelView:aRaphaelView rect:aRect]) 
    {
       _raphaelObject = [_raphaelView paper].ellipse(_rect.origin.x, _rect.origin.y, _rect.size.width, _rect.size.height);

       [self registerEvents];
    }
    
    return self;
}

/*!
    Create a new ellipse at the given point
    @param raphaelView the raphaelView that should contain this ellipse
    @param rect contains the center point and the radius of the x and y axis
*/
+ (RCEllipse)ellipseWithRaphaelView:(RCRaphaelView)aRaphaelView rect:(CPRect)aRect
{
    return [[RCEllipse alloc] initWithRaphaelView:aRaphaelView rect:aRect];
}

/*!
    Create a new ellipse at the given point
    @param raphaelView the raphaelView that should contain this ellipse
    @param point the center point
    @param xRadius the radius of the x axis
    @param yRadius the radius of the y axis
*/
+ (RCEllipse)ellipseWithRaphaelView:(RCRaphaelView)aRaphaelView atPoint:(CPPoint)aPoint xRadius:(int)anXRadius yRadius:(int)aYRadius
{
    return [[RCEllipse alloc] initWithRaphaelView:aRaphaelView atPoint:aPoint xRadius:anXRadius yRadius:aYRadius];
}

@end