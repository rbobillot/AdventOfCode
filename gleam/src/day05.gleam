import gleam/dict.{type Dict}
import gleam/int
import gleam/io
import gleam/list
import gleam/option
import gleam/order.{Gt, Lt}
import gleam/result
import gleam/string
import utils

fn sort_orders(
  orders: List(String),
  sorted: Dict(Int, List(Int)),
) -> Dict(Int, List(Int)) {
  case orders {
    [h, ..t] ->
      case string.split(h, "|") |> list.filter_map(int.parse) {
        [x, y] ->
          sort_orders(
            t,
            dict.upsert(sorted, y, fn(following) {
              case following {
                option.Some(fs) -> [x, ..fs]
                option.None -> [x]
              }
            }),
          )
        _ -> sort_orders(t, sorted)
      }
    [] -> sorted
  }
}

fn tr_validate_update(
  update: List(Int),
  ordered: Dict(Int, List(Int)),
  res: Bool,
) {
  case update {
    [x, y, ..t] ->
      case dict.get(ordered, y) |> result.unwrap([]) |> list.contains(x) {
        True -> tr_validate_update([y, ..t], ordered, True && res)
        _ -> tr_validate_update([y, ..t], ordered, False && res)
      }
    _ -> res
  }
}

fn sort_update(update: List(Int), orders: Dict(Int, List(Int))) -> List(Int) {
  list.sort(update, fn(x, y) {
    case dict.get(orders, x) |> result.unwrap([]) |> list.contains(y) {
      True -> Gt
      _ -> Lt
    }
  })
}

fn compute_middle_pages(updates: List(List(Int))) -> Int {
  updates
  |> list.filter_map(fn(u) { list.drop(u, list.length(u) / 2) |> list.first })
  |> int.sum
}

pub fn part2(orders: Dict(Int, List(Int)), updates: List(List(Int))) {
  updates
  |> list.filter(fn(u) { False == tr_validate_update(u, orders, True) })
  |> list.map(sort_update(_, orders))
  |> compute_middle_pages
}

pub fn part1(orders: Dict(Int, List(Int)), updates: List(List(Int))) {
  updates
  |> list.filter(tr_validate_update(_, orders, True))
  |> compute_middle_pages
}

pub fn day05(input: String) -> List(Int) {
  let assert [orders, updates] =
    input
    |> utils.clean_input_lines
    |> list.filter(fn(s) { string.is_empty(s) == False })
    |> list.chunk(string.contains(_, "|"))

  let orders: Dict(Int, List(Int)) = sort_orders(orders, dict.new())
  let updates =
    updates
    |> list.map(fn(s) { list.filter_map(string.split(s, ","), int.parse) })

  [part1(orders, updates), part2(orders, updates)]
}

pub fn main() {
  utils.get_input(day: 5)
  |> day05
  |> list.each(io.debug)
}
