import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import utils

pub type Tree {
  Nil
  Node(x: Int, left: Tree, right: Tree)
}

fn insert(tree: Tree, n: Int) -> Tree {
  case tree {
    Node(x, Nil, Nil) -> Node(x, insert(Nil, x + n), insert(Nil, x * n))
    Node(x, l, r) -> Node(x, insert(l, n), insert(r, n))
    Nil -> Node(n, Nil, Nil)
  }
}

fn from_list(ls: List(Int)) {
  list.fold(ls, Nil, insert)
}

fn exists(tree: Tree, n: Int, res: Bool) {
  case tree {
    Nil -> res
    Node(x, Nil, Nil) if x == n -> exists(Nil, n, True)
    Node(_, l, r) -> exists(l, n, exists(r, n, res))
  }
}

pub fn part2() {
  -1
}

pub fn part1(input: List(#(Int, List(Int)))) {
  list.filter(input, fn(tup) { from_list(tup.1) |> exists(tup.0, False) })
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

  [part1(input), part2()]
}

pub fn main() {
  utils.get_input(day: 7)
  |> day7
  |> list.each(io.debug)
}
