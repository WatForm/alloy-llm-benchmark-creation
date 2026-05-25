There is a set called "Node". Each element of "Node" has two relations named "left" and "right", and each of these relates a "Node" to zero or more elements of "Node".

For every element of "Node", there is at most one left-related "Node", and at most one "right"-related Node.

No "Node" is reachable from itself by following one or more steps through "left" or "right".
>>> not sure if this could be misinterpreted as (repeating left) or (repeating right) instead of repeating (left or right)

Each "Node" has at most one incoming "left"-or-"right" relation from other "Node"s.
That is, for any "Node", there is at most one "Node" that relates to it through either "left" or "right".

No "Node" is both in its "left" relation and in its "right" relation.
>>> this isn't very clear to me

For every "Node", the number of "Node"s reachable from it by zero or more "left" steps is equal to the number of "Node"s reachable from it by zero or more "right" steps. This count includes the "Node" itself.
>>> would it be better to define what "full" means and let the llm figure out how to implement it?