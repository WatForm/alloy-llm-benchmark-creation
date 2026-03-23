This model represents a hotel key management system. 

The key abstract entities that we're considering are Room, FrontDesk, Guest, Key, and Time. A Room has a set called "keys" which represent all keys that can unlock the room, while each Room has only one key at a particular point in time, referred to as "currentKey". 

The FrontDesk maintains the last key handed to each room and also keeps track of the occupant of each room at a given time. A Guest has a set of keys that they're holding at a particular point in time. Time is an ordered sequence and Key has an order of issuing for a room.

The system maintains a constraint that each key belongs to at most one room; that is, the keys of different rooms don't overlap.

The initial state of the model ensures that no guest holds any keys and no room has an occupant. For all rooms, the last key issued corresponds to the current key of the room.

A guest G can enter into a room R at some time if:

- The guest already has a key at that time and that key is either the current key of the room, or the next key in the ordered sequence of room R's keys.

- The current key of the room changes only if the key G has becomes the next key in the ordered sequence.

- No other guest's and room's state changes between the two time points except possibly room R's current key.

Checking out involves:

- The guest G has checked out when the room that G was staying in no longer has G as the occupant at the next time point. 

- During checkout, the last key issued for each room, all guest's keys, and current key of all rooms remain unchanged.

Checking in involves:

- A guest G checks in to a room R when G's set of keys at next time point includes the latest key issued for room R and G becomes the occupant of room R at the next time point.

- The key issued to G is the next key in the ordered sequence of room R's keys.

No other guest's and room's state changes between the two time points except possibly G's keys.

Finally, we want to ensure no unauthorized entry occurs by proving that for each time point, for each room, for each guest and for each key, if the guest enters the room, either the room does not belong to a guest or belongs to the same guest at that time point.

The check command at the end performs this check for 3 hotel management system traces with at most 2 rooms, 2 guests, and spanning over a total of 5
 points in time.