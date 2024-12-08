import day1
import gleeunit/should

const input = "
  3   4
  4   3
  2   5
  1   3
  3   9
  3   3
  "

pub fn day1_test() {
  let part1 = 11
  let part2 = 31

  input
  |> day1.day1
  |> should.equal([part1, part2])
}
