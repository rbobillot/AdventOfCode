import day7
import gleeunit/should

const input = "
  190: 10 19
  3267: 81 40 27
  83: 17 5
  156: 15 6
  7290: 6 8 6 15
  161011: 16 10 13
  192: 17 8 14
  21037: 9 7 18 13
  292: 11 6 16 20
  "

pub fn day7_test() {
  let part1 = 3749
  let part2 = 11_387

  input
  |> day7.day7
  |> should.equal([part1, part2])
}
