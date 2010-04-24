@import <AppKit/CPView.j>

@implementation RCRaphaelView : CPView
{
    id delegate @accessors;   
    JSObject _paper; 
}

- (id)initWithFrame:(CGRect)aFrame
{
    if (self = [super initWithFrame:aFrame]) {
        var bounds = [self bounds];

        _paper = Raphael(_DOMElement, bounds.width, bounds.height);
        
        var circle = _paper.circle(50, 40, 10);
        // Sets the fill attribute of the circle to red (#f00)
        circle.attr("fill", "#f00");

        // Sets the stroke attribute of the circle to white
        circle.attr("stroke", "#fff");
        //[self setMainFrameURL:document.location.href.substring(0, document.location.href.lastIndexOf('/')) + @"/Frameworks/CPVideoKit/" + [_player iFrameFileName]];
    }

    return self;
}

@end