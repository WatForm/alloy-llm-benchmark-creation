
sig Node {}

sig HeapState {
  left, right : Node -> lone Node,
  marked : set Node,
  freeList : lone Node
}

one sig h, h" in HeapState {}
one sig root extends Node {}

pred clearMarks[hs, hs" : HeapState] {
  
  no hs".marked
  
  hs".left = hs.left
  hs".right = hs.right
}


fun reachable[hs: HeapState, n: Node] : set Node {
  n + n.^(hs.left + hs.right)
}

pred mark[hs: HeapState, from : Node, hs": HeapState] {
  hs".marked = hs.reachable[from]
  hs".left = hs.left
  hs".right = hs.right
}


pred setFreeList[hs, hs": HeapState] {
  
  hs".freeList.*(hs".left) in (Node - hs.marked)
  all n: Node |
    (n !in hs.marked) => {
      no hs".right[n]
      hs".left[n] in (hs".freeList.*(hs".left))
      n in hs".freeList.*(hs".left)
    } else {
      hs".left[n] = hs.left[n]
      hs".right[n] = hs.right[n]
    }
  hs".marked = hs.marked
}

pred GC[hs: HeapState, root : Node, hs": HeapState] {
  some hs1, hs2: HeapState |
    hs.clearMarks[hs1] && hs1.mark[root, hs2] && hs2.setFreeList[hs"]
}

fact GCHappened{
  GC[h,root, h"]
}
