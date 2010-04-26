@import <Foundation/CPString.j>
@import "RCElement.j"

@implementation RCPath : RCElement
{  
   CPString _SVGString @accessors(property=SVGString, readonly);
}

- (id)initWithRaphaelView:(RCRaphaelView)aRaphaelView SVGString:(CPString)anSVGString
{
    if (self = [super initWithRaphaelView:aRaphaelView]) 
    {
       _SVGString = anSVGString;
       _raphaelObject = [_raphaelView paper].path(_SVGString);
       
       [self registerEvents];
    }
    
    return self;
}

/*!
    Returns length of the path in pixels.
    @return length in pixels
*/
- (int)totalLength
{
    if (!_raphaelObject)
        return;
    
    return _raphaelObject.getTotalLength();
}

/*!
    Returns a point at the given length of the path
    @param length length in pixels from the beginining of the path to the point
    @return CPPoint
*/
- (CPPoint)pointAtLength:(int)aLength
{
    if (!_raphaelObject)
        return;
    
    var point = _raphaelObject.getPointAtLength(aLength);
    
    return CPMakePoint(point.x, point.y);
}

/*!
    Returns the subpath string of a given path.
    @param from start length in pixels
    @param to end length in pixels
    @return an SVG string of the subpath
*/
- (CPString)subpathSVGStringFrom:(int)startLength to:(int)endLength
{
    if (!_raphaelObject)
        return;
        
    return _raphaelObject.getSubpath(startLength, endLength);
}

+ (RCPath)pathWithRaphaelView:(RCRaphaelView)aRaphaelView SVGString:(CPString)anSVGString
{
    return [[RCPath alloc] initWithRaphaelView:aRaphaelView SVGString:anSVGString];
}

@end