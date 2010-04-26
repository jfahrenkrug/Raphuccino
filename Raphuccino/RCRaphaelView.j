@import <AppKit/CPView.j>
@import "RCCircle.j"
@import "RCRect.j"
@import "RCEllipse.j"
@import "RCImage.j"
@import "RCText.j"
@import "RCPath.j"
@import "RCSet.j"

@implementation RCRaphaelView : CPView
{
    id delegate @accessors;   
    JSObject _paper @accessors(property=paper, readonly);
}

- (id)initWithFrame:(CGRect)aFrame
{
    if (self = [super initWithFrame:aFrame]) {
        var bounds = [self bounds];

        // fix in IE
        //_paper = Raphael(_DOMElement, bounds.width, bounds.height);
        _paper = Raphael(_DOMElement, '100%', '100%');
        //[self setMainFrameURL:document.location.href.substring(0, document.location.href.lastIndexOf('/')) + @"/Frameworks/CPVideoKit/" + [_player iFrameFileName]];
    }

    return self;
}


/*!
    Clears the SVG canvas
*/
- (void)clear
{
    _paper.clear();
}

/************ convenience methods ************/
- (RCCircle)circleAtPoint:(CPPoint)aPoint radius:(int)aRadius
{
    return [RCCircle circleWithRaphaelView:self atPoint:aPoint radius:aRadius];
}

- (RCRect)rectWithRect:(CPRect)aRect
{
    return [[RCRect alloc] initWithRaphaelView:self rect:aRect];
}

- (RCRect)rectWithRect:(CPRect)aRect cornerRadius:(int)aRadius
{
    return [[RCRect alloc] initWithRaphaelView:self rect:aRect cornerRadius:aRadius];
}

- (RCEllipse)ellipseWithRect:(CPRect)aRect
{
    return [[RCEllipse alloc] initWithRaphaelView:self rect:aRect];
}

- (RCEllipse)ellipseAtPoint:(CPPoint)aPoint xRadius:(int)anXRadius yRadius:(int)aYRadius
{
    return [[RCEllipse alloc] initWithRaphaelView:self atPoint:aPoint xRadius:anXRadius yRadius:aYRadius];
}

- (RCImage)imageAtPoint:(CPPoint)aPoint image:(CPImage)anImage 
{
    return [[RCImage alloc] initWithRaphaelView:self atPoint:aPoint image:anImage];
}

- (RCImage)imageWithRect:(CPRect)aRect image:(CPImage)anImage 
{
    return [[RCImage alloc] initWithRaphaelView:self rect:aRect image:anImage];
}

- (RCText)textAtPoint:(CPPoint)aPoint text:(CPString)someText
{
    return [[RCText alloc] initWithRaphaelView:self atPoint:aPoint text:someText];
}

- (RCPath)pathWithSVGString:(CPString)anSVGString
{
    return [[RCPath alloc] initWithRaphaelView:self SVGString:anSVGString];
}

- (RCSet)setWithItems:(CPArray)someItems
{
    return [[RCSet alloc] initWithItems:someItems];
}

@end