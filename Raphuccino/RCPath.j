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
    }
    
    return self;
}

+ (RCPath)pathWithRaphaelView:(RCRaphaelView)aRaphaelView SVGString:(CPString)anSVGString
{
    return [[RCPath alloc] initWithRaphaelView:aRaphaelView SVGString:anSVGString];
}

@end