/*
 * Raphuccino
 *
 * Copyright (c) 2010 Johannes Fahrenkrug (http://springenwerk.com)
 * Licensed under the MIT (http://www.opensource.org/licenses/mit-license.php) license.
 */

@import <AppKit/CPWebView.j>
@import "RCCircle.j"
@import "RCRect.j"
@import "RCEllipse.j"
@import "RCImage.j"
@import "RCText.j"
@import "RCPath.j"
@import "RCSet.j"

/*! 
    @class RCRaphaelView
    @brief The Raphael view that displays elements on an SVG canvas. Uses an iframe.
*/
@implementation RCRaphaelView : CPWebView
{
    id _delegate @accessors(property=delegate);   
    JSObject _paper @accessors(property=paper, readonly);
}

/*!
    Designated initializer: Initializes the raphaelView with the given rect
    @param aFrame the frame of the view
*/
- (id)initWithFrame:(CGRect)aFrame
{
    if (self = [super initWithFrame:aFrame]) {
        [self setFrameLoadDelegate:self];
        [self setMainFrameURL:document.location.href.substring(0, document.location.href.lastIndexOf('/')) + @"/Frameworks/Raphuccino/Resources/raphael-iframe.html"];
    }

    return self;
}

/*!
    Delegate method of the webView that gets called when it has finished loading so we can do the rest of the setup
*/
- (void)webView:(CPWebView)aWebView didFinishLoadForFrame:(id)aFrame {
    var bounds = [self bounds];
    var domWin = [self DOMWindow];

    domWin.Raphael.setWindow(domWin);

    // fix in IE: 100% doesn't work in IE, will have to fix that
    _paper = domWin.Raphael(domWin.document.getElementById('RCRaphaelViewDiv'), '100%', '98%');
    
    if (_delegate && [_delegate respondsToSelector:@selector(raphaelViewDidFinishLoading:)]) 
    {
        [_delegate raphaelViewDidFinishLoading:self];
    }
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

/* Overriding CPWebView's implementation */
- (BOOL)_resizeWebFrame {
    var width = [self bounds].size.width,
        height = [self bounds].size.height;

    _iframe.setAttribute("width", width);
    _iframe.setAttribute("height", height);
    
    if (_paper)
    {
        //console.log('resize');
        //_paper.setSize(width, height);
    }

    [_frameView setFrameSize:CGSizeMake(width, height)];
}

@end