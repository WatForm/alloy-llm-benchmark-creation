// from: https://github.com/kaiyuanw/MuAlloy/blob/master/experiments/models/singlyLinkedList.als
module SinglyLinkedList

sig List {
  header : lone Node
}

sig Node {
  link: lone Node
}

pred Acyclic (l: List) {
  no l.header or some n: l.header.*link | no n.link
}

run Acyclic
