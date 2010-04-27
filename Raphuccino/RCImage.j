/*
 * Raphuccino
 *
 * Copyright (c) 2010 Johannes Fahrenkrug (http://springenwerk.com)
 * Licensed under the MIT (http://www.opensource.org/licenses/mit-license.php) license.
 */

@import <AppKit/CPImage.j>
@import "RCElement.j"

/*! 
    @class RCImage
    @brief An image element.
*/
@implementation RCImage : RCElement
{  
   CPImage _image @accessors(property=image, readonly);
}

/*!
    Initializes the image at the given point and tries to get the size from the image
    @param raphaelView the raphaelView that should contain this image
    @param point the top left corner point
    @param image the image
*/
- (id)initWithRaphaelView:(RCRaphaelView)aRaphaelView atPoint:(CPPoint)aPoint image:(CPImage)anImage 
{
    if (aPoint === nil)
        [CPException raise:CPInvalidArgumentException reason:"Point can't be nil."];
        
    if (anImage === nil)
        [CPException raise:CPInvalidArgumentException reason:"Image can't be nil."];
    
    return [self initWithRaphaelView:aRaphaelView rect:CPMakeRect(aPoint.x, aPoint.y, [anImage size].width, [anImage size].height) image:anImage];
}

/*!
    Designated initializer: Initializes the image at the given point and sets its size
    @param raphaelView the raphaelView that should contain this image
    @param rect the top left corner point and the size of the image
    @param image the image
*/
- (id)initWithRaphaelView:(RCRaphaelView)aRaphaelView rect:(CPRect)aRect image:(CPImage)anImage 
{
    if (aRect === nil)
        [CPException raise:CPInvalidArgumentException reason:"Rect can't be nil."];
        
    if (anImage === nil)
        [CPException raise:CPInvalidArgumentException reason:"Image can't be nil."];
    
    if (self = [super initWithRaphaelView:aRaphaelView rect:aRect]) 
    {
       _image = anImage;
       _raphaelObject = [_raphaelView paper].image([_image filename], _rect.origin.x, _rect.origin.y, _rect.size.width, _rect.size.height);

       [self registerEvents];
    }
    
    return self;
}

/*!
    Creates a new image at the given point and tries to get the size from the image
    @param raphaelView the raphaelView that should contain this image
    @param point the top left corner point
    @param image the image
*/
+ (RCImage)imageWithRaphaelView:(RCRaphaelView)aRaphaelView atPoint:(CPPoint)aPoint image:(CPImage)anImage 
{
    return [[RCImage alloc] initWithRaphaelView:aRaphaelView atPoint:aPoint image:anImage];
}

/*!
    Creates a image at the given point and sets its size
    @param raphaelView the raphaelView that should contain this image
    @param rect the top left corner point and the size of the image
    @param image the image
*/
+ (RCImage)imageWithRaphaelView:(RCRaphaelView)aRaphaelView rect:(CPRect)aRect image:(CPImage)anImage 
{
    return [[RCImage alloc] initWithRaphaelView:aRaphaelView rect:aRect image:anImage];
}

@end