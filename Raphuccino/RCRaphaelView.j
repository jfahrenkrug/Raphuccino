@import <AppKit/CPView.j>
@import "RCCircle.j"

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

- (RCCircle)circleAtPoint:(CPPoint)aPoint radius:(int)aRadius
{
    return [RCCircle circleWithRaphaelView:self atPoint:aPoint radius:aRadius];
}


@end