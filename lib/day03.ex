defmodule AOC.Day03 do
  @digits Enum.map(0..9, &to_string/1)

  def part1(input) do
    data =
      input
      |> String.split("\n", trim: true)
      |> Enum.with_index()
      |> Enum.flat_map(&parse_line/1)

    {symbols, nums} =
      Enum.split_with(data, fn
        {:symbol, _} -> true
        _ -> false
      end)

    symbols = for {:symbol, point} <- symbols, into: MapSet.new(), do: point

    nums = for {num, points} <- nums, touches_symbol?(points, symbols), do: num

    Enum.sum(nums)
  end

  def part2(input) do
    data =
      input
      |> String.split("\n", trim: true)
      |> Enum.with_index()
      |> Enum.flat_map(&parse_line/1)

    {symbols, nums} =
      Enum.split_with(data, fn
        {:symbol, _} -> true
        _ -> false
      end)

    symbols =
      for {:symbol, point} <- symbols, [one, two] <- [touching_nums(nums, point)], do: one * two

    Enum.sum(symbols)
  end

  defp touching_nums(nums, point) do
    for {num, points} <- nums, touches_symbol?(points, [point]), do: num
  end

  defp touches_symbol?(points, symbols) do
    Enum.any?(points, fn {row, col} ->
      Enum.any?(symbols, fn {sr, sc} ->
        x = abs(sc - col)
        y = abs(sr - row)

        (x == 0 and y == 1) or (x == 1 and y == 0) or (x == 1 and y == 1)
      end)
    end)
  end

  defp parse_line({line, row}) do
    line
    |> String.graphemes()
    |> Enum.with_index()
    |> next_value(row)
  end

  defp next_value([{v, col} | rest] = line, row) do
    case v do
      v when v in @digits ->
        {num, rest} = parse_number(line, "", [], row)
        [num | next_value(rest, row)]

      "." ->
        next_value(rest, row)

      "" ->
        []

      _symbol ->
        [{:symbol, {row, col}} | next_value(rest, row)]
    end
  end

  defp next_value([], _row), do: []

  defp parse_number([{d, col} | rest], num, points, row) when d in @digits do
    parse_number(rest, num <> d, [{row, col} | points], row)
  end

  defp parse_number(rest, num, points, _row) do
    {{String.to_integer(num), points}, rest}
  end
end
