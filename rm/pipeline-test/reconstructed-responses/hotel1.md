The Alloy model of the above-described hotel key management system could be something like the following:

```
module KeyManagementSystem

abstract sig Time {}
sig TimeFirst extends Time { }
sig TimeNonFirst extends Time { prev: TimeFirst + TimeNonFirst }

sig Room {
    currentKey: Key, 
    keys: seq Key
} 

sig FrontDesk {
    lastKey: Room -> lone Key,
    occupant: Room -> Time -> lone Guest
}

sig Guest { 
    ownKeys: Time -> set Key 
}

sig Key { belongsTo: Room }

// Each key belongs to at most one room
fact keysBelongToOnlyOneRoom {
    all k: Key | lone k.belongsTo
}

// Initial state: No guest holds any keys, no room has an occupant
fact initialState {
    all g: Guest | no g.ownKeys
    all r: Room | 
        no FrontDesk.occupant.r && 
        FrontDesk.lastKey.r = r.currentKey
}

// Guests can enter room if they hold current key or next key
pred enter[G: Guest, R: Room, T: Time, T_next: TimeNonFirst] {
    let key = G.ownKeys.T |
    key in (R.currentKey + R.keys.after[R.currentKey]) // hold current key or next key
    no x: (Guest - G + Room - R) | x.(T.next) != x.(T) except R.currentKey  
}

// During checkout, last key issued for each room, all guest's keys, current key of all rooms remain unchanged
pred checkout[G: Guest, R: Room, T: Time, T_next: TimeNonFirst] {
    FrontDesk.occupant.R.T = G && 
    FrontDesk.occupant.R.T_next != G &&
    FrontDesk.lastKey = FrontDesk.(T_next).lastKey &&
    G.ownKeys = G.(T_next).ownKeys &&
    R.currentKey = R.(T_next).currentKey
}

// Checking in: get latest key, becomes occupant of room
pred checkIn[G: Guest, R: Room, T: Time, T_next: TimeNonFirst] {
    FrontDesk.occupant.R.T_next = G && 
    FrontDesk.lastKey.R in G.ownKeys.T_next && 
    no x: (Guest - G + Room - R) | x.(T.next) != x.(T) except G.ownKeys, R.currentKey
}

fact noUnauthorizedEntry {
    all T: Time, R: Room, G: Guest | 
        G in FrontDesk.occupant.R.T implies 
        FrontDesk.occupant.R.(T.next) in (noone + G)
    }
}

// Allow exhaustive analysis of up to 3 hotel management system traces with at most 2 rooms, 2 guests, and spanning over a total of 5 points in time.  
run {} for 3 but 2 Room, 2 Guest, 5 Time
```

The above model is not complete and may not fully represent the specifications provided in the assignment. Alloy might require adjustments according to the specific use case.