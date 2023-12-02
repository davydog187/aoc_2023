defmodule AOC.Day01Test do
  use AOCCase

  import AOC.Day01

  @moduletag day: "day01"

  test "example1" do
    input = """
    1abc2
    pqr3stu8vwx
    a1b2c3d4e5f
    treb7uchet
    """

    assert part1(input) == 142
  end

  test "example2" do
    input = """
    two1nine
    eightwothree
    abcone2threexyz
    xtwone3four
    4nineeightseven2
    zoneight234
    7pqrstsixteen
    """

    assert part2(input) == 281
    assert part2("five") == 55
    assert part2("onefscmpn6sixoneighttt") == 18
  end

  @tag part: "1"
  test "part1", %{input: input} do
    assert part1(input) == 54990
  end

  @tag part: "1"
  test "part2", %{input: input} do
    assert part2(input) == 54473
  end
end
