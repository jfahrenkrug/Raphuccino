/*
 * Raphuccino
 *
 * Copyright (c) 2010 Johannes Fahrenkrug (http://springenwerk.com)
 * Licensed under the MIT (http://www.opensource.org/licenses/mit-license.php) license.
 */

@import <Foundation/CPArray.j>
@import "RCElement.j"

function RCSetCheckValidItem(raphView, item)
{
    if (![item isKindOfClass:[RCElement class]])
    {
        [CPException raise:CPInvalidArgumentException reason:"Every item has to be a subclass of RCElement."];
    }

    if (raphView !== [item raphaelView])
    {
        [CPException raise:CPInvalidArgumentException reason:"Every item has to belong to the same RCRaphaelView."];
    }
    
    return YES;
};

/*! 
    @class RCSet
    @brief A set of elements, so you can manipulate multiple elements at once.
*/
@implementation RCSet : RCElement
{  
   CPArray _items;
}

/*!
    Initialize an empty new set
*/
- (id)init
{
    return [self initWithItems:nil];
}

/*!
    Designated initializer: Initialize a new set with the given items/elements
    @param items CPArray of RCElement subclasses to add to the set
*/
- (id)initWithItems:(CPArray)someItems
{ 
    if (self = [super init]) 
    {
       [self setItems:someItems];
    }
    
    return self; 
}

/*!
    @return the items in the set
*/
- (CPArray)items
{
    return _items;
}

/*!
    Sets the items in the set and checks if they all belong to the same raphaelView
    @param items the new array of items this set should contain
*/
- (void)setItems:(CPArray)someItems
{
    if (someItems === _items)
        return;
        
    // remove old items
    if (_raphaelObject)
    {
        _raphaelObject.items = nil;
    }
    
    if (someItems && [someItems isKindOfClass:[CPArray class]] && [someItems count] > 0)
    {
       //let's make sure they are all on the the same paper...
       var raphView = [someItems[0] raphaelView];

       for (i = 0; i < [someItems count]; i++)
       {
           RCSetCheckValidItem(raphView, someItems[i]);
       }
   
       //if we reach this point, everything should be fine.
       _raphaelView = raphView;
       _items = someItems;
       _raphaelObject = [_raphaelView paper].set();
       
       for (i = 0; i < [someItems count]; i++)
       {
           _raphaelObject.push([someItems[i] raphaelObject]);  
       } 
    } 
    else
    {
        _items = nil;
    }
}

/*!
    Adds an item to the set
    @param item the item to add
*/
- (void)addItem:(RCElement)anItem
{
    if (!anItem)
        return;
    
    // first item?
    if (!_items)
    {
        [self setItems:[anItem]];
    }
    else
    {
        RCSetCheckValidItem(_raphaelView, anItem);
        _items.push(anItem);
        _raphaelObject.push([anItem raphaelObject]);
    }
}

/*!
    Removes an item from the set
    @param item the item to remove
*/
- (void)removeItem:(RCElement)anItem
{
    if (!anItem || !_items || [_items count] < 1)
        return;

    [_items removeObject:anItem];

    for (var i = 0; i < _raphaelObject.items.length; i++)
    { 
        if (_raphaelObject.items[i] === [anItem raphaelObject])
        {
            _raphaelObject.items.splice(i,1); 
            break;
        }
    }
}

/*!
    Removes all items from the set (but not from the view)
*/
- (void)removeAllItems
{
    _items = nil;
    if (_raphaelObject)
        _raphaelObject.items = [];
}

/*!
    Creates a new set with the given items/elements
    @param items CPArray of RCElement subclasses to add to the set
*/
+ (RCSet)setWithItems:(CPArray)someItems
{
    return [[RCSet alloc] initWithItems:someItems];
}

@end