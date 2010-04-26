@import <Foundation/CPString.j>
@import "RCElement.j"

@implementation RCText : RCElement
{  
   CPString _text @accessors(property=text, readonly);
}

- (id)initWithRaphaelView:(RCRaphaelView)aRaphaelView atPoint:(CPPoint)aPoint text:(CPString)someText
{
    if (aPoint === nil)
        [CPException raise:CPInvalidArgumentException reason:"Point can't be nil."];
        
    if (someText === nil)
        [CPException raise:CPInvalidArgumentException reason:"Text can't be nil."];
    
    if (self = [super initWithRaphaelView:aRaphaelView rect:CPMakeRect(aPoint.x, aPoint.y, 0, 0)]) 
    {
       _text = someText;
       _raphaelObject = [_raphaelView paper].text(aPoint.x, aPoint.y, _text);
              
       // Sets the fill attribute of the circle to red (#f00)
       //_raphaelObject.attr("fill", "#f00");

       // Sets the stroke attribute of the circle to white
       //_raphaelObject.attr("stroke", "#fff");
    }
    
    return self;
}

+ (RCText)textWithRaphaelView:(RCRaphaelView)aRaphaelView atPoint:(CPPoint)aPoint text:(CPString)someText
{
    return [[RCText alloc] initWithRaphaelView:aRaphaelView atPoint:aPoint text:someText];
}

@end