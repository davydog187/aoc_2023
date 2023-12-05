defmodule AOC.Day04 do
  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> parse_card()
      |> calculate_points(0)
    end)
    |> Enum.sum()
  end

  defp parse_card("Card" <> rest) do
    {num, ": " <> rest} = rest |> String.trim_leading(" ") |> Integer.parse()
    [winners, numbers] = String.split(rest, "|", trim: true)
    winners = String.split(winners, " ", trim: true)
    numbers = String.split(numbers, " ", trim: true)

    {num, winners, numbers}
  end

  defp calculate_points({_num, _winners, []}, points), do: points

  defp calculate_points({card, winners, [num | numbers]}, points) do
    if num in winners do
      points = if(points == 0, do: 1, else: 2 * points)
      calculate_points({card, winners, numbers}, points)
    else
      calculate_points({card, winners, numbers}, points)
    end
  end

  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(%{}, fn line, counts ->
      {num, winners, numbers} = parse_card(line)
      winners = Enum.count(winners, fn w -> w in numbers end)
      counts = Map.update(counts, num, 1, &(&1 + 1))
      copies = 1..Map.get(counts, num, 1)

      Enum.reduce(copies, counts, fn _, counts ->
        if winners > 0 do
          cards = (num + 1)..(num + winners)

          Enum.reduce(cards, counts, fn card, counts ->
            Map.update(counts, card, 1, &(&1 + 1))
          end)
        else
          counts
        end
      end)
    end)
    |> Map.values()
    |> Enum.sum()
  end
end
