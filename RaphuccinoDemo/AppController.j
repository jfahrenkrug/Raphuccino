/*
 * AppController.j
 * RaphuccinoDemo
 *
 * Created by Johannes Fahrenkrug on April 24, 2010.
 * Copyright 2010, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>
@import <Foundation/CPBundle.j>
@import <AppKit/CPImage.j>
@import <Raphuccino/Raphuccino.j>


@implementation AppController : CPObject
{
    @outlet CPWindow    theWindow; //this "outlet" is connected automatically by the Cib
    @outlet RCRaphaelView raphaelView;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    // This is called when the application is done loading.
}

- (void)awakeFromCib
{
    [raphaelView setDelegate:self];
}

- (void)raphaelViewDidFinishLoading:(RCRaphaelView)aRaphaelView
{ 
    var circle = [RCCircle circleWithRaphaelView:raphaelView atPoint:CPMakePoint(50, 50) radius:40];
    
    var rect = [RCRect rectWithRaphaelView:raphaelView rect:CPMakeRect(100, 100, 20, 40)];
    
    var ellipse = [RCEllipse ellipseWithRaphaelView:raphaelView atPoint:CPMakePoint(100, 100) xRadius:60 yRadius:30];
    var image = [RCImage imageWithRaphaelView:raphaelView atPoint:CPMakePoint(200, 100) image:[[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] resourceURL] + "cappuccino-icon.png"]];
    
    var image2 = [RCImage imageWithRaphaelView:raphaelView rect:CPMakeRect(20, 20, 32, 18) image:[[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] resourceURL] + "trololo.jpg"]];
    
    var text = [RCText textWithRaphaelView:raphaelView atPoint:CPMakePoint(80, 60) text:@"Raphaël\nis\nawesome!"];
    
    var path = [RCPath pathWithRaphaelView:raphaelView SVGString:@"M100,100c0,50 100-50 100,0c0,50 -100-50 -100,0z"];
    
    console.log(typeof(@"test"));
    
    var set = [RCSet setWithItems:[circle, rect, ellipse]];
    [set raphaelObject].attr("stroke", "#f00");
    [set removeItem:rect];
    [set raphaelObject].attr("stroke", "#0f0");
    [set addItem:text];
    [set raphaelObject].attr("stroke", "#00f");
    [set removeAllItems];
    [set addItem:circle];
    [set raphaelObject].attr("stroke", "#000");    
    
    //[rect rotateAroundPoint:CPMakePoint(60, 60) degrees:90];
    
    [image2 translateByX:150 y:140];
    [image2 setDelegate:self];
    
    // scaling is either messed up in raphaeljs or I don't get it.
    [circle scaleByX:0.5 y:0.5 origin:CPMakePoint(70, 70)];
    
    [circle setAttr:{fill: "green"}];
    
    [circle setDelegate:self];    
    [circle raphaelObject].click(function() {[circle animateWithDuration:1000 toNewAttributes:{'fill': 'red', 'r': 80}];});
    
    //animate along path
    [rect setDelegate:self];
    [rect setAttr:{'fill': 'yellow'}]
    [rect setOnAnimationFunction:function() {console.log('animating...')}];
    [rect raphaelObject].click(function() {console.log('click'); [rect animateAlongPath:path duration:5000];}); 
    
    console.log([circle bounds]);
    
    [circle moveToFront];
    
    [rect insertBefore:ellipse];
    [rect moveToFront];
    [rect insertAfter:ellipse];
    
    console.log([path totalLength]);
    console.log([path pointAtLength:30]);
    console.log([path subpathSVGStringFrom:30 to:200]);
}


/* delegate methods */
- (void)raphaelElementDidFinishAnimating:(RCElement)anElement
{
    console.log("raphaelElementDidFinishAnimating: " + anElement);
}

- (void)raphaelElementWasClicked:(RCElement)anElement
{
    console.log("raphaelElementWasClicked: " + anElement);
}

- (void)raphaelElementWasDoubleClicked:(RCElement)anElement
{
    console.log("raphaelElementWasDoubleClicked: " + anElement);
}

- (void)raphaelElementMouseDown:(RCElement)anElement atPoint:(CPPoint)aPoint
{
    console.log("raphaelElementMouseDown: " + anElement + " atPoint:" + aPoint);
}

- (void)raphaelElementMouseUp:(RCElement)anElement atPoint:(CPPoint)aPoint
{
    console.log("raphaelElementMouseUp: " + anElement + " atPoint:" + aPoint);
}

- (void)raphaelElementMouseDidMove:(RCElement)anElement toPoint:(CPPoint)aPoint
{
    console.log("raphaelElementMouseDidMove: " + anElement + " toPoint:" + aPoint);
}

- (void)raphaelElementMouseOut:(RCElement)anElement
{
    console.log("raphaelElementMouseOut: " + anElement);
}

- (void)raphaelElementMouseOver:(RCElement)anElement
{
    console.log("raphaelElementMouseOver: " + anElement);
}

- (void)raphaelElementDidBeginHover:(RCElement)anElement
{
    console.log("raphaelElementDidBeginHover: " + anElement);
}

- (void)raphaelElementDidEndHover:(RCElement)anElement
{
    console.log("raphaelElementDidEndHover: " + anElement);
}

@end
