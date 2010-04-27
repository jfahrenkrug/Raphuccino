/*
 * AppController.j
 * RaphuccinoDemo
 *
 * Created by Johannes Fahrenkrug on April 24, 2010.
 * Copyright 2010, Springenwerk All rights reserved.
 */

@import <Foundation/CPObject.j>
@import <Foundation/CPBundle.j>
@import <AppKit/CPImage.j>
@import <Raphuccino/Raphuccino.j>


@implementation AppController : CPObject
{
    @outlet CPWindow    theWindow; //this "outlet" is connected automatically by the Cib
    @outlet RCRaphaelView raphaelView;
    
    CPImage cappIcon;
    CPImage trololoMan;
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
    cappIcon = [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] resourceURL] + "cappuccino-icon.png"];
    trololoMan = [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] resourceURL] + "trololo.jpg"];
    
    return;
}

- (IBAction)demo1:(id)sender
{
    [raphaelView clear];
    var circle = [RCCircle circleWithRaphaelView:raphaelView atPoint:CPMakePoint(250, 80) radius:80];
    [circle setAttr:{'fill': 'green'}];
    [circle animateWithDuration:2000 toNewAttributes:{'fill': 'red', 'cy': [raphaelView bounds].size.height - 20, 'r': 10} animationCurve:RCAnimationBounce];
}

- (IBAction)demo2:(id)sender
{
    [raphaelView clear];
    var image = [RCImage imageWithRaphaelView:raphaelView atPoint:CPMakePoint(50, 50) image:cappIcon];
    var startAngle = 5;
    
    [image setHoverStartFunction:function (event) {
        [image scaleByX:1.2 y:1.2];
    } endFunction:function (event) {
        [image scaleByX:1.0 y:1.0];
        [image animateWithDuration:1500 toNewAttributes:{'rotation': 0} animationCurve:RCAnimationEaseInOut];
        startAngle = 5;
    }];
    
    [image setClickFunction:function() {[image rotate:startAngle+=5];}];
}

- (IBAction)demo3:(id)sender
{
    [raphaelView clear];
    var path = [RCPath pathWithRaphaelView:raphaelView SVGString:@"M100,100c0,50 100-50 100,0c0,50 -100-50 -100,0z"];
    var ellipse = [RCEllipse ellipseWithRaphaelView:raphaelView atPoint:CPMakePoint(100, 100) xRadius:3 yRadius:6];
    [ellipse animateAlongPath:path duration:5000 rotate:YES];
}

- (IBAction)demo4:(id)sender
{
    [raphaelView clear];
    var circle = [RCCircle circleWithRaphaelView:raphaelView atPoint:CPMakePoint(100, 100) radius:80];
    [circle setAttr:{'fill': 'yellow'}];
    var rect1 = [RCRect rectWithRaphaelView:raphaelView rect:CPMakeRect(40, 60, 20, 40)];
    var rect2 = [RCRect rectWithRaphaelView:raphaelView rect:CPMakeRect(110, 60, 20, 40)];
    var ellipse = [RCEllipse ellipseWithRaphaelView:raphaelView atPoint:CPMakePoint(100, 130) xRadius:60 yRadius:20];
    var set = [RCSet setWithItems:[circle, rect1, rect2, ellipse]];
    
    [set setDoubleClickFunction:function() {[set setAttr:{'fill': 'blue'}];}];
}

- (IBAction)demo5:(id)sender
{
    [raphaelView clear];
    var circle = [RCCircle circleWithRaphaelView:raphaelView atPoint:CPMakePoint(100, 100) radius:80];
    [circle setAttr:{'fill': 'yellow'}];
    var dragging = NO;
    
    [circle setMouseDownFunction:function() {dragging = YES; [circle setAttr:{'fill': 'red'}];}];
    [circle setMouseUpFunction:function() {dragging = NO; [circle setAttr:{'fill': 'yellow'}];}];
    [circle setMouseMoveFunction:function(event) {
        if (dragging === YES)
        {
            [circle setAttr:{cx: event.x, cy: event.y}];
        }
    }];
}

- (IBAction)demo6:(id)sender
{
    [raphaelView clear];
    var circle = [RCCircle circleWithRaphaelView:raphaelView atPoint:CPMakePoint(100, 100) radius:80];
    [circle setAttr:{'fill': 'lightblue'}];
    var text = [RCText textWithRaphaelView:raphaelView atPoint:CPMakePoint(100, 100) text:@"Raphaël\nis\nawesome!"];
    [text setAttr:{'font-size': 14}];
    var recursiveRotationFunc = function() {[text rotate:0]; [text animateWithDuration:1500 toNewAttributes:{'rotation': 360} callbackFunction:recursiveRotationFunc]};
    recursiveRotationFunc();
    
    var text2 = [RCText textWithRaphaelView:raphaelView atPoint:CPMakePoint(150, 200) text:@"...but so is Cappuccino!"];
    [text2 setAttr:{'font-size': 24}];
    var recursiveElasticFunc = function() {[text2 animateWithDuration:1500 toNewAttributes:{'x': [text2 attr]['x'] < 350 ? 350 : 150} animationCurve:RCAnimationElastic callbackFunction:recursiveElasticFunc]};
    recursiveElasticFunc();
}

- (IBAction)demo7:(id)sender
{
    [raphaelView clear];
    // stolen from http://net.tutsplus.com/tutorials/javascript-ajax/an-introduction-to-the-raphael-js-library/
    var path = [RCPath pathWithRaphaelView:raphaelView SVGString:@"M 250 250 l 0 -50 l -50 0 l 0 -50 l -50 0 l 0 50 l -50 0 l 0 50 z"];
    [path setAttr:{  
        gradient: '90-#526c7a-#64a0c1',  
        stroke: '#3b4449',  
        'stroke-width': 10,  
        'stroke-linejoin': 'round',  
        rotation: -90  
    }];
    [path setDelegate:self];
}

- (IBAction)clear:(id)sender
{
    [raphaelView clear];
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
    console.log("raphaelElementMouseDown: " + anElement + " atPoint:" + aPoint.x + ", " + aPoint.y);
}

- (void)raphaelElementMouseUp:(RCElement)anElement atPoint:(CPPoint)aPoint
{
    console.log("raphaelElementMouseUp: " + anElement + " atPoint:" + aPoint.x + ", " + aPoint.y);
}

- (void)raphaelElementMouseDidMove:(RCElement)anElement toPoint:(CPPoint)aPoint
{
    console.log("raphaelElementMouseDidMove: " + anElement + " toPoint:" + aPoint.x + ", " + aPoint.y);
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
