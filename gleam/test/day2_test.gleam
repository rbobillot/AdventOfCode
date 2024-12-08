import day2
import gleeunit/should

const input = "
  7 6 4 2 1
  1 2 7 8 9
  9 7 6 2 1
  1 3 2 4 5
  8 6 4 4 1
  1 3 6 7 9
  "

pub fn day2_test() {
  let part1 = 2
  let part2 = 4

  input
  |> day2.day2
  |> should.equal([part1, part2])
}
