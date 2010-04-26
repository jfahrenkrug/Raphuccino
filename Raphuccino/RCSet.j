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

@implementation RCSet : RCElement
{  
   CPArray _items;
}

- (id)init
{
    return [self initWithItems:nil];
}

- (id)initWithItems:(CPArray)someItems
{ 
    if (self = [super init]) 
    {
       [self setItems:someItems];
    }
    
    return self; 
}

- (CPArray)items
{
    return _items;
}

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

- (void)removeAllItems
{
    _items = nil;
    if (_raphaelObject)
        _raphaelObject.items = [];
}

+ (RCSet)setWithItems:(CPArray)someItems
{
    return [[RCSet alloc] initWithItems:someItems];
}

@end