/*
 * Raphuccino
 *
 * Copyright (c) 2010 Johannes Fahrenkrug (http://springenwerk.com)
 * Licensed under the MIT (http://www.opensource.org/licenses/mit-license.php) license.
 */

@import <Foundation/CPString.j>
@import "RCElement.j"

/*! 
    @class RCText
    @brief A text element. Use "\n" if you want linebreaks.
*/
@implementation RCText : RCElement
{  
   CPString _text @accessors(property=text, readonly);
}

/*!
    Designated initializer: Initializes the text with the given string
    @param raphaelView the raphaelView that should contain this text
    @param point the coordinates for the text
    @param text the text (use "\n" if you want linebreaks.)
*/
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
              
       [self registerEvents];
    }
    
    return self;
}

/*!
    Creates a new text with the given string
    @param raphaelView the raphaelView that should contain this text
    @param point the coordinates for the text
    @param text the text (use "\n" if you want linebreaks.)
*/
+ (RCText)textWithRaphaelView:(RCRaphaelView)aRaphaelView atPoint:(CPPoint)aPoint text:(CPString)someText
{
    return [[RCText alloc] initWithRaphaelView:aRaphaelView atPoint:aPoint text:someText];
}

@end