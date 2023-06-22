namespace my;

entity IntegerKeyedEntity {
    key id : Integer;
    items: Composition of many IntegerKeyedItem on items.parent = id;
    item: Composition of one IntegerKeyedItem on item.id = id;
};

entity IntegerKeyedItem {
    key id : Integer;
    parent : Integer;
    subItems: Composition of many IntegerKeyedSubItem on subItems.parent = id;
};

entity IntegerKeyedSubItem {
    key id : Integer;
    parent : Integer;    
};

entity StringKeyedEntity {
    key id : String;
};
