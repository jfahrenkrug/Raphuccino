@import <AppKit/CPImage.j>
@import "RCElement.j"

@implementation RCImage : RCElement
{  
   CPImage _image @accessors(property=image, readonly);
}

- (id)initWithRaphaelView:(RCRaphaelView)aRaphaelView atPoint:(CPPoint)aPoint image:(CPImage)anImage 
{
    if (aPoint === nil)
        [CPException raise:CPInvalidArgumentException reason:"Point can't be nil."];
        
    if (anImage === nil)
        [CPException raise:CPInvalidArgumentException reason:"Image can't be nil."];
    
    return [self initWithRaphaelView:aRaphaelView rect:CPMakeRect(aPoint.x, aPoint.y, [anImage size].width, [anImage size].height) image:anImage];
}

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

       // Sets the fill attribute of the circle to red (#f00)
       //_raphaelObject.attr("fill", "#f00");

       // Sets the stroke attribute of the circle to white
       //_raphaelObject.attr("stroke", "#fff");
    }
    
    return self;
}

+ (RCImage)imageWithRaphaelView:(RCRaphaelView)aRaphaelView atPoint:(CPPoint)aPoint image:(CPImage)anImage 
{
    return [[RCImage alloc] initWithRaphaelView:aRaphaelView atPoint:aPoint image:anImage];
}

+ (RCImage)imageWithRaphaelView:(RCRaphaelView)aRaphaelView rect:(CPRect)aRect image:(CPImage)anImage 
{
    return [[RCImage alloc] initWithRaphaelView:aRaphaelView rect:aRect image:anImage];
}

@end