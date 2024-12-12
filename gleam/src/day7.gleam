import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import utils

pub type Tree {
  Nil
  Node(x: Int, left: Tree, center: Tree, right: Tree)
}

fn concat(x: Int, y: Int) -> Int {
  { int.to_string(x) <> int.to_string(y) } |> int.parse |> result.unwrap(0)
}

fn insert(tree: Tree, n: Int) -> Tree {
  case tree {
    Node(x, Nil, Nil, Nil) ->
      Node(x, insert(Nil, x + n), insert(Nil, concat(x, n)), insert(Nil, x * n))
    Node(x, l, c, r) -> Node(x, insert(l, n), insert(c, n), insert(r, n))
    Nil -> Node(n, Nil, Nil, Nil)
  }
}

fn from_list(ls: List(Int)) {
  list.fold(ls, Nil, insert)
}

fn exists(tree: Tree, n: Int, cc: Bool, res: Bool) {
  case tree {
    Nil -> res
    Node(x, Nil, Nil, Nil) if x == n -> exists(Nil, n, cc, True)
    Node(_, l, _, r) if !cc -> exists(l, n, cc, exists(r, n, cc, res))
    Node(_, l, c, r) ->
      exists(l, n, cc, exists(c, n, cc, exists(r, n, cc, res)))
  }
}

pub fn part2(input: List(#(Int, List(Int)))) {
  list.filter(input, fn(tup) { from_list(tup.1) |> exists(tup.0, True, False) })
  |> list.fold(0, fn(acc, tup) { acc + tup.0 })
}

pub fn part1(input: List(#(Int, List(Int)))) {
  list.filter(input, fn(tup) { from_list(tup.1) |> exists(tup.0, False, False) })
  |> list.fold(0, fn(acc, tup) { acc + tup.0 })
}

pub fn day7(input: String) -> List(Int) {
  let input =
    input
    |> utils.clean_input_lines
    |> list.filter_map(string.split_once(_, ":"))
    |> list.map(fn(tup) {
      case tup {
        #(x, xs) -> {
          let x = x |> int.parse |> result.unwrap(0)
          let xs = xs |> string.split(" ") |> list.filter_map(int.parse)
          #(x, xs)
        }
      }
    })

  [part1(input), part2(input)]
}

pub fn main() {
  utils.get_input(day: 7)
  |> day7
  |> list.each(io.debug)
}
