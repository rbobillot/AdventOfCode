import day03
import gleeunit/should

const input = "
  xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
  "

pub fn day03_test() {
  let part1 = 161
  let part2 = 48

  input
  |> day03.day03
  |> should.equal([part1, part2])
}
