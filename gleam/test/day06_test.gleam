import day06
import gleeunit/should

const input = "
  ....#.....
  .........#
  ..........
  ..#.......
  .......#..
  ..........
  .#..^.....
  ........#.
  #.........
  ......#...
  "

pub fn day06_test() {
  let part1 = 41
  let part2 = -1

  input
  |> day06.day06
  |> should.equal([part1, part2])
}
