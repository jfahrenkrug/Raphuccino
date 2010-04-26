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
    // This is called when the cib is done loading.
    // You can implement this method on any object instantiated from a Cib.
    // It's a useful hook for setting up current UI values, and other things. 
    var circle = [RCCircle circleWithRaphaelView:raphaelView atPoint:CPMakePoint(50, 50) radius:40];
    
    var rect = [RCRect rectWithRaphaelView:raphaelView rect:CPMakeRect(60, 60, 20, 40)];
    
    var ellipse = [RCEllipse ellipseWithRaphaelView:raphaelView atPoint:CPMakePoint(100, 100) xRadius:60 yRadius:30];
    var image = [RCImage imageWithRaphaelView:raphaelView atPoint:CPMakePoint(200, 100) image:[[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] resourceURL] + "cappuccino-icon.png"]];
    
    var image2 = [RCImage imageWithRaphaelView:raphaelView rect:CPMakeRect(20, 20, 32, 18) image:[[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] resourceURL] + "trololo.jpg"]];
    
    var text = [RCText textWithRaphaelView:raphaelView atPoint:CPMakePoint(80, 60) text:@"Raphaël\nis\nawesome!"];
}

@end
