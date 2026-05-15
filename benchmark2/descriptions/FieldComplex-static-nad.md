This model describes rules for scheduling and managing games in a field complex.

The model has three sets: 'Field', 'Game', and 'Date'. Each 'Game' has exactly one 'Field' and exactly one 'Date' attached to it. 

There is also a special set, 'FieldComplex', which has a set of 'Game' objects attached to it, labeled as 'schedule'. 

Any 'Game' that is not listed in the 'schedule' of 'FieldComplex' must have neither a 'Field' nor a 'Date' attached to it. 

Any 'Game' that is listed in the 'schedule' of 'FieldComplex' must have precisely one 'Field' and one 'Date' associated with it. 

Two distinct 'Game' objects sharing the same 'Field' cannot have the same 'Date'. This implies that there are unique dates for games played on the same field.

There must exist a game in the 'FieldComplex' schedule with a 'Date' and 'Field'. This predicate is meant to confirm the presence of a scheduled game with all necessary fields filled in.

There exists a 'Game' that has not been scheduled, i.e. is not a part of 'FieldComplex' schedule. 
