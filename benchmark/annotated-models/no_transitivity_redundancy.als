open util/relation

sig N { next: set N }

fact
{
  -- only acyclic relation
  acyclic[next, N]
  -- constraint to check against examples and counter examples
  no next.^next & next
}
