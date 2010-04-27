/*
 * Raphuccino
 *
 * Copyright (c) 2010 Johannes Fahrenkrug (http://springenwerk.com)
 * Licensed under the MIT (http://www.opensource.org/licenses/mit-license.php) license.
 */

@import "RCElement.j"

/*! 
    @class RCRect
    @brief A rectangle element.
*/
@implementation RCRect : RCElement
{  
   int _cornerRadius @accessors(property=radius, readonly);
}

/*!
    Initializes the rect with the given size and origin
    @param raphaelView the raphaelView that should contain this rect
    @param rect the top left corner point and the size of the rect
*/
- (id)initWithRaphaelView:(RCRaphaelView)aRaphaelView rect:(CPRect)aRect
{
    return [self initWithRaphaelView:aRaphaelView rect:aRect cornerRadius:0];
}

/*!
    Designated initializer: Initializes the rect with the given size and origin
    @param raphaelView the raphaelView that should contain this rect
    @param rect the top left corner point and the size of the rect
    @param cornerRadius radius of the corners (rounded corners)
*/
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

/*!
    Creates a new rect with the given size and origin
    @param raphaelView the raphaelView that should contain this rect
    @param rect the top left corner point and the size of the rect
*/
+ (RCRect)rectWithRaphaelView:(RCRaphaelView)aRaphaelView rect:(CPRect)aRect
{
    return [[RCRect alloc] initWithRaphaelView:aRaphaelView rect:aRect];
}

/*!
    Creates a new rect with the given size and origin
    @param raphaelView the raphaelView that should contain this rect
    @param rect the top left corner point and the size of the rect
    @param cornerRadius radius of the corners (rounded corners)
*/
+ (RCRect)rectWithRaphaelView:(RCRaphaelView)aRaphaelView rect:(CPRect)aRect cornerRadius:(int)aRadius
{
    return [[RCRect alloc] initWithRaphaelView:aRaphaelView rect:aRect cornerRadius:aRadius];
}

@end